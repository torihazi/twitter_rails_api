class AlbaGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  class_option :model, type: :string, default: 'sample'

  def create_alba_base_file
    base_resource_path = File.join('app/resources', 'base_resource.rb')
    
    unless File.exist?(base_resource_path)
      create_file base_resource_path, <<~RUBY
        class BaseResource
          include Alba::Resource
        end
      RUBY
    end
  end

  def create_alba_file
    template 'alba_template.erb', File.join('app/resources', class_path, "#{file_name}_resource.rb")
  end

  def run_rubocop
    generated_file_path = File.join('app/resources', class_path, "#{file_name}_resource.rb")
    system("bundle exec rubocop -a #{generated_file_path}", out: File::NULL, err: File::NULL)
  end

  private
  def model
    options['model']
  end
end