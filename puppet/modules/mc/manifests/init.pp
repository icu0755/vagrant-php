class mc {
    package { "mc":
        name    => "mc",
        ensure  => "latest",
		require => Class['apt'];
    }
}