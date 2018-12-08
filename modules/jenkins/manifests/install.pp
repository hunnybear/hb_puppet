class jenkins::install() {

	yumrepo { 'jenkins':
		baseurl    => 'https://pkg.jenkins-ci.org/redhat/jenkins.repo',
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