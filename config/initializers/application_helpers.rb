class Float
  def to_money
    sprintf("%0.0f", self)
  end

  def to_percent
    sprintf("%0.2f", self)
  end
end

class BigDecimal
  def to_money
    sprintf("%0.0f", self)
  end

  def to_percent
    sprintf("%0.2f", self)
  end
end

class String
  def initial
    f = self.chars.first
    f ? "#{f}." : ""
  end
end

module ActionView
  module Helpers
    module TranslationHelper
      def localize(*args)
        #Avoid I18n::ArgumentError for nil values
        I18n.localize(*args) unless args.first.nil?
      end
      # l() still points at old definition
      alias l localize
    end
  end
end

# Set default form builder
ActionView::Base.default_form_builder = TourismFormBuilder

class WillPaginateLinkRenderer < WillPaginate::ActionView::LinkRenderer

  protected

    def page_number(page)
      if @options[:link_id]
        id = "#{@options[:link_id]}_page#{page}"
      else
        prefix = @collection.to_s
        prefix = @collection.klass.to_s if @collection.try(:klass)
        id = "#{prefix.tableize}_page#{page}"
      end
      unless page == current_page
        tag(:li, link(page, page, :rel => rel_value(page), :id => id, 'data-param' => 'page', 'data-value' => page))
      else
        tag(:li, tag(:span, page, :class => 'active'), :id => id, :class => "active")
      end
    end

    def previous_or_next_page(page, text, classname)
      if page
        tag(:li, link(text, page, 'data-param' => 'page', 'data-value' => page), :class => classname)
      else
        tag(:li, tag(:span, text), :class => classname + ' disabled')
      end
    end

    def gap
      text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
      %(<li class="disabled"><a>#{text}</a></li>)
    end

    def html_container(html)
      tag(:ul, html, container_attributes)
    end

end

module ActiveRecord
  class Base

    # Set the columns and values used for local data
    def self.local_data(*args)
      if args && args.length > 0
        options = args.extract_options!
        settings = {
          :options => options,
          :args => args.dup
        }

        # Check extra data hash or method
        if options[:extra_data].present?
          settings[:extra_data] = options[:extra_data]
        end

        # Check extra data hash or method
        if options[:columns_filter].present?
          settings[:columns_filter] = options[:columns_filter]
        end

        # Check data filter
        if options[:data_filter].present?
          settings[:data_filter] = options[:data_filter]
        end

        # Check data scope
        if options[:scope].present?
          settings[:scope] = options[:scope]
        end

        @local_data_setting = settings

      elsif @local_data.nil?
        @local_data = []
        @local_data_setting ||= {}

        settings = @local_data_setting
        options = settings[:options] || {}
        args = settings[:args] || []

        # Add attributes
        if options[:attributes].nil? || options[:attributes] == :all
          @local_data += attribute_names.map(&:to_sym)
        elsif options[:attributes]
          @local_data += options[:attributes]
        end

        # Add methods
        @local_data += args

        # To add extra columns, if they are defined
        # All associations have to defined there
        if options[:extra_columns].present?
          if options[:extra_columns].is_a? Array
            @local_data += options[:extra_columns]
          elsif options[:extra_columns].is_a? Symbol and self.respond_to? options[:extra_columns]
            @local_data += self.send(options[:extra_columns])
          end
        end

        @local_data.uniq!

        # To filter columns, if a columns filter is given
        if settings[:columns_filter].present? and settings[:columns_filter].is_a? Symbol and self.respond_to? settings[:columns_filter]
          @local_data = @local_data.select { |column| self.send(settings[:columns_filter], column) }
        end
      end

      # Return all attribute names by default
      @local_data || attribute_names.map(&:to_sym)
    end

    def self.local_data_settings
      @local_data_setting || {}
    end

    def self.local_data_scoped
      scope = self.local_data_settings[:scope]
      # Rails.logger.debug "settings: #{self.local_data_settings.map{|k,v| k.to_s + ' => ' + v.to_s}.join(', ')}"
      if scope.respond_to?(:call)
        scoped = scope.bind(self).call
      elsif scope.is_a? Symbol and self.respond_to? scope
        scoped = self.send(scope)
      end
      scoped
    end

    def self.scoped_by_ability(ability)
      self.accessible_by(ability)
    end

    def local_data
      data = {}
      settings = self.class.local_data_settings

      extra_data = settings[:extra_data]
      extra_data = self.send(extra_data) if extra_data.is_a?(Symbol)
      extra_data = {} unless extra_data.is_a? Hash

      self.class.local_data.each do |atr|
        if extra_data[atr].present?
          value = origin_value = extra_data[atr]
        elsif self.respond_to? atr
          origin_value = self.send atr
          value = local_data_default_value_handler(origin_value)
        end

        # Use data filter, if it's defined
        data_filter = settings[:data_filter]
        if data_filter.respond_to?(:call)
          value = data_filter.bind(self).call(atr, value, origin_value)
        elsif data_filter.is_a? Symbol and self.respond_to? data_filter
          value = self.send(data_filter, atr, value, origin_value)
        end

        # Skip attribute if value is nil
        data[atr] = value unless value.nil?
      end

      data
    end

    private

      def local_data_default_value_handler(value)
        if value.is_a? Time or value.is_a? Date or value.is_a? DateTime
          I18n.l(value, :format => :long)
        elsif value.is_a? ActiveRecord::Associations
          (value.name if value.respond_to?(:name)) || value.id
        else
          value
        end
      end

  end
end
