class CustomFormBuilder < Formtastic::SemanticFormBuilder
 
  def text_field(field, options = {})
    value = object.send(field)
    value = "%01.2f" % value if value.is_a?(Float) or value.is_a?(BigDecimal)
    value = value.to_s.gsub('.', ',')
 
    options[:value] = value
    super(field, options)
  end
 
end
