node {
    try {
        stage('Build') {
            git credentialsId: '83edbe93-3f96-4586-aa6b-6f7119472c06', url: 'git@github.com:ffmeyer/nblog-api.git'
            env.RACK_ENV = 'development'
            ruby('bundle install --with test')
            ruby('rspec --format progress --format RspecJunitFormatter --out results/rspec.xml')
            junit 'results/rspec.xml'
        }
        stage('Deploy to QA') {
            echo 'deploy on heroku'
            deploy('qa')
        }
        stage('Run Functional Tests') {
            echo 'test'
            ruby('cucumber')
            cucumber '**/*.json'
            junit 'results/TEST-*.xml'
        }
        stage('Deploy to UAT') {
            echo 'deploy on heroku'
            deploy('uat')
        }
        stage('Run Acceptance Tests') {
            echo 'test'
            ruby('cucumber -p uat --tag @smoke')
        }
        stage('Promote to Production') {
            deploy_prod()
            ruby('cucumber -p production --tag @smoke')
        }
    }
    catch (err) {
        currentBuild = 'Falhou o build'
        junit 'results/*.xml'
        cucumber '**/*.json'
        throw err
    }
}

def ruby(String commands) {
    sh "bash -c 'source ~/.bashrc && rbenv global 2.3.3 && ${commands}'"
}

def deploy(String env) {
    sh 'rm -rf .git && git init'
    sh "heroku git:remote -a nblog-api-${env}-ffmeyer"
    sh "git add . && git commit -m 'deploy'"
    sh "git push heroku master --force"
}

def deploy_prod() {
    sh 'rm -rf .git && git init'
    sh "heroku git:remote -a nblog-api-ffmeyer"
    sh "git add . && git commit -m 'deploy'"
    sh "git push heroku master --force"
}