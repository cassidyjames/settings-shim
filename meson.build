project('com.github.cassidyjames.settings-shim', 'vala', 'c')

gnome = import('gnome')

executable(
    meson.project_name(),
    join_paths('src', 'Application.vala'),
    dependencies: [
        dependency('gio-unix-2.0'),
        dependency('glib-2.0'),
        dependency('gtk+-3.0'),
    ],
    install: true
)

install_data (
    join_paths ('data', meson.project_name () + '.desktop'),
    install_dir: join_paths (get_option ('datadir'), 'applications')
)

