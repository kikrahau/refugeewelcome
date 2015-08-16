module ApplicationHelper

	def create_image_checkboxes_for klass
		klass.map do |node|
      array = []
      array << content_tag(:input,nil, type: 'checkbox',name: 'category_ids[]',value: node.id, id: "_#{node.id}", class: 'image-checkbox')
      array << content_tag(:label, for: "_#{node.id}") do
      	image_tag node.image, class: 'checkbox-image'
      end
      array
    end.flatten.join.html_safe
	end

end
