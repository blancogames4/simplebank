package util

import "github.com/spf13/viper"

type Config struct {
	DBDriver       string `mapstructure:"DB_DRIVER"`
	DBSource       string `mapstructure:"DB_SOURCE"`
	ServiceAddress string `mapstructure:"SERVICE_ADDRESS"`
}

func LoadConfig(path string) (config Config, err error) {
	viper.AddConfigPath(path)
	viper.AddConfigPath(path)
	viper.SetConfigName("app.env") // Name of the environment file (you can also use "app" if that’s what you prefer)
	viper.SetConfigType("env")     // Specify "env" as the config type for environment variable files

	viper.AutomaticEnv() // Automatically override values from the environment

	err = viper.ReadInConfig()
	if err != nil {
		return
	}

	err = viper.Unmarshal(&config)
	return
}
