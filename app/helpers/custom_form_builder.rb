class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def switch_checkbox(name, dark: false)
    slider_class = 'slider round'
    slider_class.concat ' bg-bg-dark' if dark
    @template.content_tag(:label, nil, class: 'switch') do
      @template.check_box(@object_name, name) +
        @template.content_tag(:span, nil, class: slider_class)
    end
  end
end
