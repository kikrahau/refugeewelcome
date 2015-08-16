module ApplicationHelper

	def create_checkboxes_for klass
		klass.map do |category|
      content_tag(:div, class: 'checkbox') do
        content_tag :label do
          content_tag :input,category.name, type: 'checkbox',name: 'category_ids[]',value: category.id
        end
      end
    end.join.html_safe
	end

end
