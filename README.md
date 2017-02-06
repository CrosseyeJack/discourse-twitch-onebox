# Discourse Twitch Onebox

This plugin for Discourse extends Onebox to add support for properly embedding [Twitch](https://twitch.tv/) streams, videos (VODs), and Clips in Discourse posts. Videos embed as protocol-relative and with auto-play disabled.
Calling this a V1 as I want to change up the templating can styling of the player for out use case.

## Installation

Add the plugin's repository URL to your container's `app.yml` file, for example:

```yml
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - mkdir -p plugins
          - git clone https://github.com/crosseyejack/discourse-twitch-onebox.git  ## Hosted on GitHub
```

Rebuild the container:

```sh
cd /var/discourse
./launcher rebuild app
```

For the plugin to apply retroactively, you'll need to rebake old posts:

```sh
cd /var/discourse
./launcher enter app
rake posts:rebake
```

## Modifications
This plugin is a fork of the version found at https://github.com/critcola/discourse-twitch-onebox customized for my own needs.

## License

The Discourse Twitch Onebox plugin is released under the [MIT License](LICENSE).

The original plugin was licensed under the MIT and I don't see any reason why my modifications to the plugin shouldn't fall under the same license.
