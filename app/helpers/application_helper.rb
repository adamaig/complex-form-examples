# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def remove_child_link(name, url, f)
    f.hidden_field(:_destroy) + 
    link_to(name, url, :id => "destroy_#{dom_id(f.object)}", :class => "remove_template", :"data-model" => f.object.class.name.underscore)
  end
  
  def add_template_link(name, url, klass, target, options = {})
    link_to(name, url, :class => "add_template #{ options[:extra_css_classes]}", 
            :"data-model" => klass.name.underscore, :"data-target" => target)
  end
  
  def new_fields_template(klass, options = {})

    options[:object] ||= klass.new
    options[:template_for] ||= klass.name.underscore
    options[:partial] ||= options[:template_for]
    options[:form_builder_local] ||= :f
    
    if ! content_given?("#{options[:template_for]}_template")
      content_for "#{options[:template_for]}_template" do
        content_tag(:div, :id => "#{options[:template_for]}_template", :style => "display: none") do
          fields_for options[:object], :index => "new_#{options[:template_for]}" do |f| 
            render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
          end
        end
      end
    end
  end
  
  def content_given?(name)
    content = instance_variable_get("@content_for_#{name}")
    ! content.nil?
  end
end
