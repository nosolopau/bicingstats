# Bicingstats

This application provided an historic record of usage data for Barcelona's public bikes system, by offering information retrieved from the [Bicing API](https://blog.rocboron.at/bicing-api/) by [Roc Boronat](http://rocboronat.net).

## Configuration

The application uses a configuration file that can be found at `config/config.yml`. Inside this configuration file there are two pairs key-value, as follows: 

    samples_service_url: http://rocboronat.net/barcelonabicing/bcnJ?all=1
    token: "123"

The param `samples_service_url` indicates the URL for data retrieval. The param +token+ is a security paraphrase that can be used to securize access to the update data function.

