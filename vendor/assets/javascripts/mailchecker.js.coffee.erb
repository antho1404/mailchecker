$.fn.mail_checker = (token, options) ->
  if typeof token is 'object'
    options = token
    token = null
  
  defaults = 
    token: null
    trigger_on: "change"
    success:        () ->
    invalid_format: () ->
    invalid_domain: () ->
    temporary_mail: () ->
    error:          (error) -> console.error(error)
  
  domain = document.domain.match /([^.]+)\.[^.]+.?$/

  domain = domain[0] if domain and domain.length > 0
  options = $.extend {}, defaults, options
  
  unless token
    token = options.token
    unless token
      console.error "Missing token parameter"
      return

  $(this).bind options.trigger_on, ->
    _this = this
    data =
      token: token
      domain: domain
      email: $(this).val()
    $.ajax
      url: "<%= Mailchecker.url %>"
      data: data
      dataType: "json"
      complete: (jqXHR, textStatus) ->
        options.success.apply(_this)         if jqXHR.status is 200
        options.invalid_format.apply(_this)  if jqXHR.status is 422
        options.invalid_domain.apply(_this)  if jqXHR.status is 502
        options.temporary_mail.apply(_this)  if jqXHR.status is 406
        options.error.apply(_this, [$.parseJSON(jqXHR.responseText).error]) if jqXHR.status is 400

