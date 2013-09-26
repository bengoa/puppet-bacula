define bacula::director::fileset (
  $name = $title,
  $signature = '',
  $compression = '',
  $onefs = '',
  $fstype = '',
  $include = '',
  $exclude = '',
  $template = 'bacula/filesets.conf.erb'
) {

  include bacula

  $array_filesets_fstype = is_array($fstype) ? {
    false     => $filesets_fstype ? {
      ''      => [],
      default => [$filesets_fstype],
    },
    default   => $filesets_fstype,
  }

  $array_filesets_include = is_array($include) ? {
    false     => $filesets_include ? {
      ''      => [],
      default => [$filesets_include],
    },
    default   => $filesets_include,
  }

  $array_filesets_exclude = is_array($exclude) ? {
    false     => $filesets_exclude ? {
      ''      => [],
      default => [$filesets_exclude],
    },
    default   => $filesets_exclude,
  }

  file { "fileset-${name}.conf":
    ensure  => $bacula::manage_file,
    path    =>  "${director_configs_dir}/fileset-${name}.conf",
    mode    => $bacula::config_file_mode,
    owner   => $bacula::config_file_owner,
    group   => $bacula::config_file_group,
    require => Package['bacula::director_package'],
    notify  => $bacula::manage_service_autorestart,
    content => template($template),
    replace => $bacula::manage_file_replace,
    audit   => $bacula::manage_audit,
  }

}
