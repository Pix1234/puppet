class parsoid {
    include apt
    include nginx

    apt::source { 'parsoid':
        location => 'http://releases.wikimedia.org/debian',
        release  => 'jessie-mediawiki',
        repos    => 'main',
        key      => {
            'id'     => 'BE0C9EFB1A948BF3C8157E8B811780265C927F7C',
            'server' => 'hkp://keyserver.ubuntu.com:80',
        },
    }

    ssl::cert { 'wildcard.miraheze.org': }

    file { '/etc/nginx/sites-enabled/default':
        ensure  => absent,
        require => Package['nginx'],
    }

    file { '/etc/nginx/nginx.conf':
        ensure  => present,
        content => template('parsoid/nginx.conf.erb'),
        require => Package['nginx'],
    }

    nginx::site { 'parsoid':
        ensure  => present,
        source  => 'puppet:///modules/parsoid/nginx/parsoid',
    }

    package { 'parsoid':
        ensure  => present,
        require => Apt::Source['parsoid'],
    }

    service { 'parsoid':
        ensure    => running,
        require   => Package['parsoid'],
        subscribe => File['/etc/mediawiki/parsoid/settings.js'],
    }

    # The name of the wiki (or the URL in form <wikiname>.miraheze.org. DO NOT INCLUDE WIKI.
    $wikis = [
                '3dicxyz',
                '8station',
                'aacenterpriselearning',
                'adnovum',
                'aescapes',
                'ageofimperialism',
                'air',
                'aktpos',
                'alanpedia',
                'algopedia',
                'allbanks2',
                'applebranch',
                'arabudland',
                'aryaman',
                'atheneum',
                'augustinianum',
                'aurcusonline',
                'bgo',
                'biblicalwiki',
                'biblio',
                'braindump',
                'carving',
                'casuarina',
                'cbmedia',
                'cec',
                'chandrusweths',
                'christipedia',
                'ciso',
                'civitas',
                'clementsworldbuilding',
                'clicordi',
                'cssandjsschoolboard',
                'datachron',
                'development',
                'dicfic',
                'dmw',
                'drunkenpeasantswiki',
                'elainarmua',
                'ernaehrungsrathh',
                'essway',
                'etpo',
                'eva',
                'extload',
                'ezdmf',
                'fishpercolator',
                'foodsharinghamburg',
                'frontdesks',
                'games',
                'geirpedia',
                'gen',
                'gnc',
                'grandtheftwiki',
                'hftqms',
                'hobbies',
                'hshsinfoportal',
                'hsooden',
                'idtest',
                'ilearnthings',
                'imsts',
                'inazumaeleven',
                'irc',
                'islamwissenschaft',
                'izanagi',
                'lancemedical',
                'lbsges',
                'lclwiki',
                'littlebigplanet',
                'lizard',
                'luckandlogic',
                'lunfeng',
                'maiasongcontest',
                'mecanon',
                'menufeed',
                'meregos',
                'meta',
                'musiclibrary',
                'musictabs',
                'mydegree',
                'ndtest',
                'neuronpedia',
                'newknowledge',
                'newtrend',
                'nidda23',
                'nwp',
                'ofthevampire',
                'openconstitution',
                'panorama',
                'paodeaoda',
                'partup',
                'pflanzen',
                'priyo',
                'pq',
                'qwerty',
                'rawdata',
                'recherchesdocumentaires',
                'ric',
                'robloxscripters',
                'rpcharacters',
                'safiria',
                'secondcircle',
                'shopping',
                'simonjon',
                'sirikot',
                'sjuhabitat',
                'skyfireflyff',
                'snowthegame',
                'soshomophobie',
                'stellachronica',
                'studynotekr',
                'taylor',
                'teleswiki',
                'thefosters',
                'thehushhushsaga',
                'tme',
                'tochki',
                'torejorg',
                'touhouengine',
                'unikum',
                'urho3d',
                'videogames',
                'vrgo',
                'walthamstowlabour',
                'webflow',
                'wikibooks',
                'wikicervantes',
                'wikihoyo',
                'worldbuilding',
                'xdjibi',
                'yacresources',
                'yggdrasilwiki',
                'yourosongcontest',
                'youtube',
    ]

    file { '/etc/mediawiki/parsoid/settings.js':
        ensure  => present,
        content => template('parsoid/settings.js'),
    }
}
