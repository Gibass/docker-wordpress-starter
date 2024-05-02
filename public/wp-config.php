<?php

require dirname(__DIR__) . '/vendor/autoload.php';

// Load ENV variables
Dotenv\Dotenv::createUnsafeImmutable(dirname(__DIR__))->load();

/** Define DB Config */
define('DB_HOST', getenv('MYSQL_DB_HOST')); // MySQL hostname
define('DB_NAME', getenv('MYSQL_DB_NAME')); // The name of the database for WordPress
define('DB_USER', getenv('MYSQL_USERNAME')); // MySQL database username
define('DB_PASSWORD', getenv('MYSQL_PASSWORD')); //MySQL database password
define('DB_CHARSET', getenv('DB_CHARSET') ?: 'utf8') ; // Database Charset to use in creating database tables.

/** Authentication Unique Keys and Salts. */
const AUTH_KEY = 'put your unique phrase here';
const SECURE_AUTH_KEY = 'put your unique phrase here';
const LOGGED_IN_KEY = 'put your unique phrase here';
const NONCE_KEY = 'put your unique phrase here';
const AUTH_SALT = 'put your unique phrase here';
const SECURE_AUTH_SALT = 'put your unique phrase here';
const LOGGED_IN_SALT = 'put your unique phrase here';
const NONCE_SALT = 'put your unique phrase here';

/** WordPress Database Table prefix. */
$table_prefix  = 'wp_';

/** For developers: WordPress debugging mode. */
const WP_DISABLE_FATAL_ERROR_HANDLER = false;
const WP_DEBUG = false;
const WP_DEBUG_LOG = false;
const WP_DEBUG_DISPLAY = false;
const SAVEQUERIES = false;

/** Custom WordPress Install Path.*/
// Sets the site's admin location and the site's location, respectively.
define('WP_SITEURL', getenv('WP_HOME') . '/wp');
define('WP_HOME', getenv('WP_HOME') );

// Sets the content location, related to what's defined on composer.json file.
define( 'WP_CONTENT_DIR', dirname( __FILE__ ) . '/wp-content' );

// Sets the plugins location, related to what's defined on composer.json file.
const WP_CONTENT_URL = WP_HOME . '/wp-content';
const WP_PLUGIN_URL = WP_CONTENT_URL . '/plugins';

/** Disable Admin File Editor */
const DISALLOW_FILE_EDIT = true;
const DISALLOW_FILE_MODS = true;

/** Disable auto Update */
const AUTOMATIC_UPDATER_DISABLED = true;
const WP_AUTO_UPDATE_CORE = false;

/** SSL */
const FORCE_SSL_ADMIN = true;

// That's all, stop editing! Happy publishing.

// Absolute path to the WordPress directory.
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/wp/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';