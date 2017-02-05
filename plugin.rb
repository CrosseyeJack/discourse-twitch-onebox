# name: Discourse Twitch Onebox
# about: Adds support for properly embedding Twitch streams, videos, and Clips within Discourse.
# version: 1.0
# authors: Daniel Marquard
# authors: Crosseye Jack
# url: https://github.com/crosseyejack/discourse-twitch-onebox

# Onebox for Twitch streams.
enabled_site_setting :twitch_onebox_height
enabled_site_setting :twitch_onebox_width
enabled_site_setting :twitch_onebox_autoplay

class Onebox::Engine::TwitchStreamOnebox
	include Onebox::Engine

	REGEX = /^https?:\/\/(?:www\.)?twitch.tv\/(?!directory)([a-zA-Z0-9_]{4,25})$/
	matches_regexp REGEX

	def channel
		@url.match(REGEX)[1]
	end
	
	def to_html
		"<iframe src=\"//player.twitch.tv/?channel=#{channel}&autoplay=#{SiteSetting.twitch_onebox_autoplay}\" width=\"#{SiteSetting.twitch_onebox_width}\" height=\"#{SiteSetting.twitch_onebox_height}\" frameborder=\"0\" style=\"overflow: hidden;\" scrolling=\"no\" allowfullscreen=\"allowfullscreen\"></iframe>"
	end
end

# Onebox for Twitch videos.
class Onebox::Engine::TwitchVideoOnebox
	include Onebox::Engine

	REGEX = /^https?:\/\/(?:www\.)?twitch.tv\/(?:(?!directory)[a-zA-Z0-9_]{4,25}\/v|videos)\/(\d+)(?:(?:\?(?:.+)?t=)(\w+))?&?/
	matches_regexp REGEX

	def id
		@url.match(REGEX)[1]
	end
  
	def timestamp
		"&time=" +@url.match(REGEX)[2]
	end
	
	def to_html
		"<a href='#{link}' target='_blank'>#{title}</a><iframe src=\"//player.twitch.tv/?video=v#{id}#{timestamp}&autoplay=#{SiteSetting.twitch_onebox_autoplay}\" width=\"#{SiteSetting.twitch_onebox_width}\" height=\"#{SiteSetting.twitch_onebox_height}\" frameborder=\"0\" style=\"overflow: hidden;\" scrolling=\"no\" allowfullscreen=\"allowfullscreen\"></iframe>"
	end
end

# Onebox for Twitch Clips.
class Onebox::Engine::TwitchClipsOnebox
	include Onebox::Engine

	REGEX = /^https?:\/\/clips.twitch.tv\/([a-zA-Z0-9_]{4,25})\/([^#\?\/]+)/
	matches_regexp REGEX

	def channel
		@url.match(REGEX)[1]
	end
	
	def clip_name
		@url.match(REGEX)[2]
	end
	
	def to_html
		"<iframe src=\"//clips.twitch.tv/embed?clip=#{channel}/#{clip_name}&autoplay=#{SiteSetting.twitch_onebox_autoplay}\" width=\"#{SiteSetting.twitch_onebox_width}\" height=\"#{SiteSetting.twitch_onebox_height}\" frameborder=\"0\" style=\"overflow: hidden;\" scrolling=\"no\" allowfullscreen=\"allowfullscreen\"></iframe>"
	end
end
