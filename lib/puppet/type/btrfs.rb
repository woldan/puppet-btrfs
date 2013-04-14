# Puppet type to represent a btrfs filesystem.
Puppet::Type.newtype(:btrfs) do
  # Doc-string:
  @doc = <<-'EOT'
       Manages btrfs filesystems.

         Example:
           
           btrfs { "/data":
             device     => '/dev/sdb',
             label      => 'mydata',
           }
  EOT

  # We know how to ensure our presence:
  ensurable

  # Parameter: mountpoint
  newparam(:mountpoint, :namevar => true) do
    desc 'The local path the filesystem is to be mounted at.'
  end

  # Parameter: device
  newparam(:device) do
    desc 'The local path of the block device to use for the filesystem.'
  end

  # Parameter: label
  newparam(:label) do
    desc 'A textual label that can be associated with the btrfs filesystem.'
  end

end
