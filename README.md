# php-docker-images-for-ci

[![CircleCI](https://circleci.com/gh/umutphp/php-docker-images-for-ci/tree/master.svg?style=svg)](https://circleci.com/gh/umutphp/php-docker-images-for-ci/tree/master)

A repository  of Docker files to create images from official PHP images (latest version per master master branches) with some CI tools installed. 

The tools that are installed by Composer are isolated by using different folder per tool and linked to `/usr/local/bin` folder.

## List of PHP Images ##
- php:5.6
- php:7.0
- php:7.1
- php:7.2
- php:7.3

## List of CI Tools ##
- [PHP Code Sniffer](https://github.com/squizlabs/PHP_CodeSniffer)
- [PHP Copy/Paste Detector (PHPCPD)](https://github.com/sebastianbergmann/phpcpd)
- [PHP Dead Code Detector](https://github.com/sebastianbergmann/phpdcd)
- [SensioLabs Security Checker](https://github.com/sensiolabs/security-checker)
- [PhpMetrics](https://www.phpmetrics.org/)
- [Psecio Parse](https://github.com/psecio/parse)
- [PHP VarDump Check](https://github.com/JakubOnderka/PHP-Var-Dump-Check)
- [PHP Parallel Lint](https://github.com/JakubOnderka/PHP-Parallel-Lint)
- [PHP Magic Number Detector (PHPMND)](https://github.com/povils/phpmnd)
- [composer.json fixer](https://github.com/kubawerlos/composer-json-fixer)
- [PHP Assumptions](https://github.com/rskuipers/php-assumptions)
- [churn-php](https://github.com/bmitch/churn-php) (>=PHP 7.1)
- [Fink](https://github.com/dantleech/fink) (>=PHP 7.1)
- [PHPMD](https://github.com/phpmd/phpmd)

## Custom Tools ##
- **Gitignore Checker:** `gitignore_checker` checks the .gitignore file under the directory that the command executed and finds if there are file or files both in the git ignore file and the repository.
- **Git Merge Conflict Marker Checker:** `merge_conflict_checer` checks all the files in the given folder (current folder is checked if not given) to find the forgotten merge conflict markers like "<<<<<<< HEAD". 

## How to use ##
1. **Directly From Docker Hub:** You use the images already built from [umutphp/php-docker-images-for-ci](https://hub.docker.com/r/umutphp/php-docker-images-for-ci).
2. **Build Your Own:** Copy any of the Dockerfile files and build your own image.

## How to use images locally ##
* A sample execution for [PHP Code Sniffer](https://github.com/squizlabs/PHP_CodeSniffer);

```
docker run -v /path/to/project:/app umutphp/php-docker-images-for-ci:7.1 phpcs /app
```

* A sample execution for [SensioLabs Security Checker](https://github.com/sensiolabs/security-checker);

```
docker run -v /path/to/project:/app umutphp/php-docker-images-for-ci:7.1 security-checker security:check /app/composer.lock
```

* A sample execution for [Psecio Parse](https://github.com/psecio/parse);

```
docker run -v /path/to/project:/app umutphp/php-docker-images-for-ci:7.1 /root/.composer/vendor/bin/psecio-parse scan /app
```

## How to Use in Gitlab CI ##
You need to enable Docker executors on Gitlab CI. You can find sample job definitions for executing the tools on Gitlab CI pipeline for your repo. 

* A sample job definition for [PHP Code Sniffer](https://github.com/squizlabs/PHP_CodeSniffer);

```
code_sniffer:
    stage: stage_name
    image: umutphp/php-docker-images-for-ci:7.1
    script:
        - cd /path/to/code/base
        - phpcs 
```

* A sample job definition for [SensioLabs Security Checker](https://github.com/sensiolabs/security-checker);

```
security_composer_checker:
    stage: stage_name
    image: umutphp/php-docker-images-for-ci:7.1
    script:
        - security-checker security:check /path/to/composer.lock
```

* A sample job definition for [Psecio Parse](https://github.com/psecio/parse);

```
security_psecio_parse:
    stage: stage_name
    image: umutphp/php-docker-images-for-ci:7.1
    script:
        - /tools/bin/psecio-parse/.composer/vendor/bin/psecio-parse scan /path/to/your/codebase/
```
