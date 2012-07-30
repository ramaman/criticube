LANGUAGES = [
  'English'#,
  # 'Arabic',
  # 'Bengali',
  # 'Croatian',
  # 'Czech',
  # 'Danish',
  # 'Dutch',
  # 'Esperanto',
  # 'Estonian',
  # 'Finnish',
  # 'French',
  # 'Galician',
  # 'German',
  # 'Greek',
  # 'Gujarati',
  # 'Hebrew',
  # 'Hindi',
  # 'Hungarian',
  # 'Icelandic',
  # 'Indonesian',
  # 'Irish',
  # 'Italian',
  # 'Japanese',
  # 'Korean',
  # 'Latin',
  # 'Latvian',
  # 'Lithuanian',
  # 'Macedonian',
  # 'Malay',
  # 'Maltese',
  # 'Mandarin Chinese',  
  # 'Norwegian',
  # 'Persian',
  # 'Polish',
  # 'Portugese',
  # 'Romanian',
  # 'Russian',
  # 'Serbian',
  # 'Slovak',
  # 'Slovenian',
  # 'Spanish',
  # 'Swahili',
  # 'Swedish',
  # 'Tagalog',  
  # 'Tamil',
  # 'Telugu',
  # 'Thai',
  # 'Turkish',
  # 'Ukrainian',
  # 'Urdu',
  # 'Vietnamese'
]

RESERVED_WORDS = [
  'criticube',
  'url',
  'about',
  'account',
  'add',
  'admin',
  'administrator',    
  'api',
  'app',
  'apps',
  'archive',
  'archives',
  'auth',
  'blog',
  'cancel',
  'config',
  'configuration',
  'connect',
  'contact',
  'contacts',  
  'contract',
  'create',
  'delete',
  'direct_messages',
  'downloads',
  'edit',
  'email',
  'faq',
  'favorites',
  'feed',
  'feeds',
  'follow',
  'follows',
  'followers',
  'following',
  'help',
  'home',
  'invitations',
  'invite',
  'invites',
  'jobs',
  'log_in',
  'login',
  'log_out',
  'logout',
  'logs',
  'map',
  'maps',
  'message',
  'messages',  
  'news',
  'oauth',
  'oauth_clients',
  'openid',
  'external',  
  'privacy',
  'password',
  'passwords',  
  'register',
  'remove',
  'reply',
  'replies',
  'rss',
  'save',
  'load',
  'edit',
  'edit_user',
  'edituser',
  'edit_profile',
  'editprofile',      
  'update',
  'delete',
  'search',
  'session',
  'sessions',
  'setting',
  'settings',
  'sign_up',
  'signup',
  'sign_in',
  'signin',
  'sign_out',      
  'signout',
  'sitemap',
  'ssl',
  'subscribe',
  'terms',
  'trends',
  'unfollow',
  'unsubscribe',
  'url',
  'widget',
  'widgets',
  'xfn',
  'xmpp'
]

OBJECT_WORDS = [
  'avatar',
  'avatars',
  'argument',
  'arguments',
  'fact',
  'facts',
  'user',
  'users',
  'group',
  'groups',
  'cube',
  'cubes',
  'security',
  'career',
  'careers',
  'job',
  'jobs',
  'location',
  'locations',
  'topic',
  'topics',
  'node',
  'nodes',
  'owner',
  'owners',
  'profile',
  'profiles',
  'brand',
  'brands',
  'business',
  'businesses',
  'company',
  'companies',
  'school',
  'schools',
  'code',
  'codes',
  'followage',
  'followages',
  'support',
  'supports',
  'challenge',
  'challenges',
  'reference',
  'references',
  'statement',
  'statements',
  'research',
  'researches',
  'researcher',
  'researchers',
  'picture',
  'pictures',
  'photo',
  'photos',
  'question',
  'questions',
  'answer',
  'answers',
  'statement',
  'statements',
  'doc',
  'docs',
  'document',
  'documents',
  'file',
  'files',
  'page',
  'pages',
  'comment',
  'comments'
]

ALL_RESERVED_WORDS = RESERVED_WORDS + OBJECT_WORDS + LANGUAGES
ALL_RESERVED_WORDS = ALL_RESERVED_WORDS + (RESERVED_WORDS + OBJECT_WORDS).collect{|w| w.capitalize} + LANGUAGES.collect{|w| w.downcase} 