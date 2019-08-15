SimpleForm.setup do |config|
  config.wrappers :default, class: :input,
                            hint_class: :field_with_hint, error_class: 'has-error' do |b|
    b.use :html5

    b.use :placeholder

    b.optional :maxlength

    b.optional :minlength

    b.optional :pattern

    b.optional :min_max

    b.optional :readonly

    b.use :label_input, class: 'control-label input-label'
    b.use :hint,  wrap_with: { tag: :span, class: 'help-block' }
    b.use :error, wrap_with: { tag: :span, class: 'help-block' }
  end

  config.default_wrapper = :default

  config.boolean_style = :nested

  config.button_class = 'btn'

  config.error_notification_tag = :div

  config.error_notification_class = 'error_notification'

  config.label_text = ->(label, _required, _explicit_label) { label.to_s }

  config.default_form_class = nil

  config.browser_validations = false

  config.input_class = 'form-control'

  config.boolean_label_class = 'checkbox'
end
