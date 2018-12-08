class jenkins::install() {

	yumrepo { 'jenkins':
		baseurl    => 'http://pkg.jenkins.io/redhat',
		descr      => 'The jenkins repository',
		enabled    => '1',
		gpgcheck   => '1',
		gpgkey     => 'https://jenkins-ci.org/redhat/jenkins-ci.org.key',
	}

	package{'jenkins':
		ensure	=> latest,
		require	=> Yumrepo['jenkins'],
	}
}