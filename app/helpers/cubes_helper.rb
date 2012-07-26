module CubesHelper

  def managers_list(managers_array, display_count, fallback_url)
    managers_array_array = []
    if dmanagers_array.length < display_count-1
      dmanagers_array.each do |manager|
        managers_array_array << (link_to(managers.fast_name, managers))
      end
    else
      dmanagers_array[0..(display_count-1)].each do |vote|
        managers_array_array << (link_to(managers.fast_name, managers))
      end
      if (dmanagers_array.count - display_count) > 0
        managers_array_array << (link_to( 'and ' + pluralize(managers_array.count - display_count, 'other'), fallback_url))
      end
    end
    return managers_array_array.join(', ').html_safe
  end

end
