require 'fileutils'

Puppet::Type.type(:btrfs).provide(:default) do
  desc "Provides support to manage btrfs filesytems"

  # The btrfs command => puppet converts this into a handy method:
  commands :btrfscmd => "btrfs"

  # The mkfs.btrfs command => puppet converts this into a handy method:
  commands :mkfscmd => "/sbin/mkfs.btrfs"

  # The mount command => puppet converts this into a handy method:
  commands :mountcmd => "mount"

  # The umount command => puppet converts this into a handy method:
  commands :umountcmd => "umount"

  def create
    #TODO: we might wanna look a little harder than that:
    unless btrfscmd("filesystem", "show").split("\n").detect { |line| line.split("\s")[-1] == @resource[:device] }
      # .. create filesystem on requested block device ..
      mkfscmd "-L", @resource[:label], @resource[:device]
    end

    # .. mount filesystem ..
    mountcmd "-t", "btrfs", @resource[:device], @resource[:mountpoint]
  end

  def destroy
    umountcmd @resource[:mountpoint]
    #TODO: should we do anything else?
  end

  def exists?
    if mountcmd().split("\n").detect { |line| line.split("\s")[0] == @resource[:device] }
      true
    else
      false
    end
  end
  
end
