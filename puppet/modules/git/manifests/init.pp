class git {
    package { "git":
        name    => "git",
        ensure  => "latest",
		require => Class['apt'];
    }
}