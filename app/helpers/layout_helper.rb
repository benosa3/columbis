# -*- encoding : utf-8 -*-
# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def view_switcher?
    params[:controller] == 'claims' and params[:action] == 'index' and (is_admin? or is_boss? or is_accountant?)
  end

  # Temporary solution
  def body_class
    'middle_resoluition'
  end

end
