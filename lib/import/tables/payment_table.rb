module Import
  module Tables
    module OperatorTable
      extend Tables::DefaultTable

      FORMAT =
        {
          :claim_num               => {:type => 'Int', :may_nil => false, :value => nil},
          :date_in                 => {:type => 'String', :may_nil => true, :value => nil},
          :currency                => {:type => 'Float', :may_nil => true, :value => nil},
          :amount                  => {:type => 'Int', :may_nil => true, :value => nil},
          :description             => {:type => 'String', :may_nil => true, :value => nil},
          :form                    => {:type => 'String', :may_nil => true, :value => nil},
          :amount_prim             => {:type => 'Int', :may_nil => true, :value => nil},
          :approved                => {:type => 'String', :may_nil => true, :value => nil},
          :course                  => {:type => 'String', :may_nil => true, :value => nil},
          :reversed_course          => {:type => 'String', :may_nil => true, :value => nil}
        }

      class << self
        def columns_count
          21
        end

        def sheet_number
          3
        end

        def import(row, company)
          puts "Start import Operator"
          puts row.to_s

          data_row = prepare_data(row, company)

          params = create_operator_params(data_row, company)
          if (!check_exist(params, company))
            operator = Operator.new(params)
            operator.company = company
            if operator.save
              if data_row[:address][:value]
                operator.create_address(company_id: company.id, joint_address: data_row[:address][:value] )
              end
              puts "Operator was importing"
              true
            else
              puts operator.errors.inspect
              puts "Operator not save"
              false
            end
          else
            puts "Operator exist"
          end
        end

        private

        def prepare_data(row, company)
          data_row = Marshal.load(Marshal.dump(FORMAT))
          row.each_with_index do |field, i|
            key = data_row.keys[i]
            data_row[key][:value] = field unless field.blank?
          end
          data_row
        end

        def check_exist(params, company)
          operator = Operator.where(name: params[:name], company_id: company.id).first
          operator
        end

        def create_operator_params(row, company)
          {
            :name => row[:name][:value],
            :full_name => row[:full_name][:value],
            :register_number => row[:register_number][:value],
            :register_series => row[:register_series][:value],
            :inn => row[:inn][:value],
            :ogrn => row[:ogrn][:value],
            :code_of_reason => row[:code_of_reason][:value],
            :phone_numbers => row[:phone_numbers][:value],
            :site => row[:site][:value],
            :banking_details =>row[:banking_details][:value],
            :actual_address => row[:actual_address][:value],
            :insurer => row[:insurer][:value],
            :insurer_full_name => row[:insurer_full_name][:value],
            :insurer_address => row[:insurer_address][:value],
            :actual_insurer_address => row[:actual_insurer_address][:value],
            :insurer_provision => row[:insurer_provision][:value],
            :insurer_contract => row[:insurer_contract][:value],
            :insurer_contract_date => row[:insurer_contract_date][:value],
            :insurer_contract_start => row[:insurer_contract_start][:value],
            :insurer_contract_end => row[:insurer_contract_end][:value],
          }
        end
      end
    end
  end
end