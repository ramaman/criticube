module ApplicationHelper
  include AutoHtml
  
  def title
    base_title = "Criticube"
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end

  def short_string(text, limit)
    if text.length > limit
      text[0..limit] + '..'
    else
      text
    end
  end

  def description
    if @description.nil?
      'Criticube lets you share, discover, and discuss opinions'
    else
      short_string(@description, 500)
    end
  end  

  def htmlize(text,html_options={}, options={})
    text = parse_urls(text)
    text = '' if text.nil?
    text = text.dup
    start_tag = tag('p', html_options, true)
    text = sanitize(text) unless options[:sanitize] == false
    text = text.to_str
    text.gsub!(/\r\n?/, "\n") # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}") # 2+ newline -> paragraph
    # text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline -> br
    text.insert 0, start_tag
    text.html_safe.safe_concat("</p>")
  end

  def simple_htmlize(text)
    simple_format(parse_urls(text))
  end  
  
  def parse_urls(text)
    auto_html(text){link(:target => '_blank', :rel => 'nofollow')}
  end

  def friendly_datetime_fixed(time)
    time.strftime('%B %d, %Y at %l:%M %p')
  end
  
  def friendly_date(time)
    time.strftime('%B %d, %Y')
  end

  def friendly_datetime(time)
    if time.to_datetime > 48.hours.ago
      return time.strftime('%l:%M %p') 
    else
      return time.strftime('%B %d, %Y')
    end
  end

  def monthyear(time)
    time.strftime('%b %Y')
  end

  def year(time)
    time.strftime('%Y')
  end

  def keywords_array
    base_keywords = "thoughts, opinions, investigation, social, media"
    if @keywords.nil?
      base_keywords
    else
      [@keywords, base_keywords].join(',')
    end
  end

  def current_full_url
    request.protocol + request.host + request.fullpath
  end

  def full_url(url)
    request.protocol + request.host + url
  end

  def url_for(options = {})
    if (options.class == Cube) || (options.class == User)
      vanity_path(options.page_name)
    else
      original = super(options)
      # I tried this in order to improve performance:
      return original
    end
  end


end
