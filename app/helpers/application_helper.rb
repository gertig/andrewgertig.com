module ApplicationHelper

  def markdown(text)
    output = text.lines.map do |line|
      process_line line
    end.join
    RedcarpetCompat.new(output, :fenced_code, :gh_blockcode)
  end

  def process_line(line)
    match = match_gist line
    return "<div id=\"#{match[1]}\" class=\"gist-files\">Loading gist...</div>" if match

    match = match_youtube line
    return render(:partial => 'youtube', :locals => { :video => match[1] }) if match

    line
  end

  def match_gist(line)
    line.match(/\{\{gist\s+(.*)\}\}/)
  end

  def match_youtube(line)
    line.match(/^http.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/)
  end


  def background_color_helper(params)
    if params[:controller] == "home"
      return ["#336699", "#996699", "#336600", "#8FB7EE", "#1C4754", "#61707D"].sample
    else
      return "#091827"
    end
  end

  # is the post the marathon post?
  def marathon_post_helper
    params[:id].to_s == "2" || params[:id].to_s == "how-to-hack-a-marathon-if-you-arent-a-runner"
  end


end
