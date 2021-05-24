const path = require('path');
const TsconfigPathsPlugin = require('tsconfig-paths-webpack-plugin');
const { NODE_ENV = 'production' } = process.env;
const webpack = require('webpack');
const createStyledComponentsTransformer = require('typescript-plugin-styled-components').default;
const styledComponentsTransformer = createStyledComponentsTransformer();

console.log(`-- Webpack <${NODE_ENV}> build --`);

module.exports = {
    entry: {
        main: './src/main.ts',
    },
    mode: NODE_ENV,
    target: 'node',
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: '[name].js',
    },
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: [{
                    loader: 'ts-loader',
                    options: {
                        getCustomTransformers: () => ({ before: [styledComponentsTransformer] }),
                    },
                }],
                exclude: /node_modules/,
            },
        ],
    },
    resolve: {
        extensions: ['.tsx', '.ts', '.js', '.jsx'],
        plugins: [new TsconfigPathsPlugin({ configFile: './tsconfig.build.json' })],
    },
    plugins: [
        new webpack.IgnorePlugin({
            /**
             * There is a small problem with Nest's idea of lazy require() calls,
             * Webpack tries to load these lazy imports that you may not be using,
             * so we must explicitly handle the issue.
             * Refer to: https://github.com/nestjs/nest/issues/1706
             */
            checkResource(resource) {
                const lazyImports = [
                    '@nestjs/microservices',
                    '@nestjs/microservices/microservices-module',
                    '@nestjs/websockets',
                    '@nestjs/websockets/socket-module',
                    '@nestjs/platform-express',
                    'cache-manager',
                    'class-validator',
                    'class-transformer',
                ];

                if (!lazyImports.includes(resource)) {
                    return false;
                }

                try {
                    require.resolve(resource);
                } catch (err) {
                    return true;
                }

                return false;
            },
        }),
    ],
    stats: {
        errorDetails: true
    },
};