class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def switch_checkbox(name)
    @template.content_tag(:label, nil, class: 'switch') do
      @template.check_box(@object_name,name) +
      @template.content_tag(:span, nil, class: 'slider round')
    end
  end
end
