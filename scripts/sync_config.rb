#!/usr/bin/env ruby


LOCAL_DIR = "#{ENV["HOME"]}/.config/"
# local_git_dir = "#{ENV["CFG_GIT_DIR"]}/"
LOCAL_GIT_DIR = "/home/sebastian/dotfiles/nvim/"

GIT_PATH = "#{ENV["HOME"]}/dotfiles/"
LOCAL_PATH="#{ENV["HOME"]}/.config/"

CONFIG_DIRS = [
  "nvim/",
  "alacritty/",
  "awesome/",
]

def walk_dir_and_sync(dir, prefix)
  Dir["#{dir}*"].each do |f|
    if File.directory? f
      dirname = File.basename(f) + "/"
      walk_dir_and_sync(f+"/", prefix+dirname)
    else
      filename = File.basename(f)
      git_dest = LOCAL_GIT_DIR + prefix + filename
      system("cat #{f} > #{git_dest}")
    end
  end
end


def sync_config_dirs
  CONFIG_DIRS.each do |dir|
    walk_dir_and_sync(LOCAL_PATH+dir, "")
  end
end

sync_config_dirs()
