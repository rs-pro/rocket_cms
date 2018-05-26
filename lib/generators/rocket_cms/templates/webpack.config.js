'use strict';

var path = require('path');
var webpack = require('webpack');
var ManifestPlugin = require('webpack-manifest-plugin');

var MiniCssExtractPlugin = require("mini-css-extract-plugin");
var autoprefixer = require('autoprefixer');
var CompressionPlugin = require("compression-webpack-plugin");

var host = process.env.HOST || 'localhost'
var devServerPort = <%= port %>;

var production = process.env.NODE_ENV === 'production';

const extractSass = new MiniCssExtractPlugin({
  filename: production ? "[name].[chunkhash].css" : "[name].css",
});

var sassExtractor = () => {
  return [
    {
      loader: "extracted-loader",
    },
    MiniCssExtractPlugin.loader,
    {
      loader: "babel-loader",
      options: {
        cacheDirectory: true
      }
    },
    {
      loader: "css-loader",
      options: {
        sourceMap: true
      }
    }, {
      loader: "sass-loader",
      options: {
        sourceMap: true
      }
    }
  ]
}

var config = {
  mode: production ? "production" : "development",
  entry: {
    // Sources are expected to live in $app_root
    //vendor: [],
    application: 'application.es6',
  },

  module: {
      rules: [
          {
            test: /(\.es6)$/,
            use: {
              loader: "babel-loader",
              options: {
                cacheDirectory: true
              }
            }
          },
          {
            test: /(\.pug)$/,
            loader: "pug-loader",
            query: {}
          },
          {
            test: /\.vue/,
            use: {
              loader: "vue-loader",
            }
          },
          {
            test: /\.(jpe?g|png|gif)$/i,
            use: "file-loader"
          },
          {
            test: /\.svg$/i,
            exclude: /inline/i,
            use: "file-loader"
          },
          {
            test: /\.woff($|\?)|\.woff2($|\?)|\.ttf($|\?)|\.otf($|\?)|\.eot($|\?)/,
            use: 'file-loader'
          },
          {
            test: /\.(s?css|sass)$/i,
            use: sassExtractor()
          },
      ]
  },

  output: {
    // Build assets directly in to public/webpack/, let webpack know
    // that all webpacked assets start with webpack/

    // must match config.webpack.output_dir
    path: path.join(__dirname, "..", "public", "webpack"),
    publicPath: '/webpack/',

    filename: production ? '[name]-[chunkhash].js' : '[name].js',
    chunkFilename: production ? '[name]-[chunkhash].js' : '[name].js',
  },

  resolve: {
    modules: [
      path.resolve(__dirname, "..", "webpack"),
      path.resolve(__dirname, "..", "node_modules"),
    ],
    extensions: [".es6", ".vue", ".sass", ".css", ".js"],
    alias: {
      '~': path.resolve(__dirname, "..", "webpack"),
    }
  },

  plugins: [
    extractSass,
    new ManifestPlugin({
      writeToFileEmit: true,
      publicPath: production ? "/webpack/" : 'http://' + host + ':' + devServerPort + '/webpack/',
    }),
    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      "window.jQuery": "jquery",
    })
  ],
  optimization: {
    runtimeChunk: { name: 'vendor' },
    splitChunks: {
      chunks: "initial",
      cacheGroups: {
        default: false,
        vendors: {
          chunks: "initial",
          test: /[\\/]node_modules[\\/]/,
          priority: -10,
          name: "vendor",
        },
      },
    },
  },
};

if (production) {
  config.plugins.push(
    new webpack.DefinePlugin({ // <--key to reduce React's size
      'process.env': { NODE_ENV: JSON.stringify('production') }
    }),
    new CompressionPlugin({
        asset: "[path].gz",
        algorithm: "gzip",
        test: /\.js$|\.css$/,
        threshold: 4096,
        minRatio: 0.8
    })
  );
  config.output.publicPath = '/webpack/';
} else {
  config.plugins.push(
    new webpack.NamedModulesPlugin()
  )

  config.devServer = {
    port: devServerPort,
    disableHostCheck: true,
    headers: { 'Access-Control-Allow-Origin': '*' },
  };
  config.output.publicPath = 'http://' + host + ':' + devServerPort + '/webpack/';
  // Source maps
  config.devtool = 'source-map';
}

module.exports = config;


