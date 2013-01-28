Chronic::Parser.class_eval do
  def pre_normalize(text)
    text = text.to_s.downcase
    text.gsub!(/\./, ':')
    text.gsub!(/['"]/, '')
    text.gsub!(/,/, ' ')
    text.gsub!(/^second /, '2nd ')
    text.gsub!(/\bsecond (of|day|month|hour|minute|second)\b/, '2nd \1')
    text = Chronic::Numerizer.numerize(text)
    text.gsub!(/\-(\d{2}:?\d{2})\b/, 'tzminus\1')
    text.gsub!(/([\/\-\,\@])/) { ' ' + $1 + ' ' }
    text.gsub!(/(?:^|\s)0(\d+:\d+\s*pm?\b)/, ' \1')
    text.gsub!(/\btoday\b/, 'this day')
    text.gsub!(/\btomm?orr?ow\b/, 'next day')
    text.gsub!(/\byesterday\b/, 'last day')
    text.gsub!(/\bnoon\b/, '12:00pm')
    text.gsub!(/\bmidnight\b/, '24:00')
    text.gsub!(/\bnow\b/, 'this second')
    text.gsub!('quarter', '15')
    text.gsub!('half', '30')
    text.gsub!(/(\d{1,2}) (to|till|prior to|before)\b/, '\1 minutes past')
    text.gsub!(/(\d{1,2}) (after|past)\b/, '\1 minutes future')
    text.gsub!(/\b(?:ago|before(?: now)?)\b/, 'past')
    text.gsub!(/\bthis (?:last|past)\b/, 'last')
    text.gsub!(/\b(?:in|during) the (morning)\b/, '\1')
    text.gsub!(/\b(?:in the|during the|at) (afternoon|evening|night)\b/, '\1')
    text.gsub!(/\btonight\b/, 'this night')
    text.gsub!(/\b\d+:?\d*[ap]\b/,'\0m')
    text.gsub!(/\b(\d{2})(\d{2})(am|pm)\b/, '\1:\2\3')
    text.gsub!(/(\d{1,3})(hr|hour|min[ute]?s?)/, '\1 \2' ) # mod - Allow no space
    text.gsub!(/(\d)([ap]m|oclock)\b/, '\1 \2')
    text.gsub!(/\b(hence|after|from)\b/, 'future')
    text.gsub!(/^\s?an? /i, '1 ')
    text.gsub!(/\b(\d{4}):(\d{2}):(\d{2})\b/, '\1 / \2 / \3') # DTOriginal
    text.gsub!(/\b0(\d+):(\d{2}):(\d{2}) ([ap]m)\b/, '\1:\2:\3 \4')
    text
  end
end