pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Ansible Playbooks') {
            agent {
                label 'admin'
            }
            steps {
                script {
                    // Run the Ansible playbook using the 'ansible-playbook' command
                    sh """
                        ansible-playbook playbooks/common_packages.yml &&
                        ansible-playbook playbooks/secure_configuration.yml &&
                        ansible-playbook playbooks/patching_playbook.yml &&
                        ansible-playbook web-lb/site.yml &&
                        ansible-playbook database/managedb.yml &&
                        ansible-playbook database/mariadb.yml &&
                        ansible-playbook database/phpmyadmin.yml
                    """
                }
            }
        }
        stage('Run python script to tag a pipeline') {
            agent {
                label 'admin'
            }
            when {
                expression {
                    def userInput = input message: 'Please provide a tag to continue:', ok: 'Proceed',
                                          parameters: [string(name: 'Tag team name', defaultValue: '', description: 'Enter correct name to tag the pipeline')]
                    
                    if (userInput == null) { // if input is aborted
                        error "Pipeline aborted by user"
                    } else if (userInput != 'Code Killers') {
                        error "Incorrect tag. Build failed."
                    }
                    // We must return true to continue
                    return true
                }
            }
            steps {
                echo 'Tagging pipeline...'
                // Add the steps required to tag the pipeline here
            }
        }
    }
}