import jenkins.model.*
import org.jenkinsci.plugins.workflow.job.WorkflowJob
import org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition
import com.dabsquared.gitlabjenkins.GitLabPushTrigger
import hudson.plugins.git.*

def createOrUpdatePipelineJob(
    String jobName,
    String gitlabRepoUrl,
    String gitCredentialsId,
    String jenkinsfilePath,
    String branchName,
    boolean autoBuild
    ) {
    Jenkins jenkins = Jenkins.instance

    WorkflowJob job = jenkins.getItem(jobName)
    if (job == null) {
        job = jenkins.createProject(WorkflowJob, jobName)
        println("Created job: ${jobName}")
    } else {
        println("Job already exists: ${jobName}")
    }

    UserRemoteConfig config = new UserRemoteConfig(gitlabRepoUrl, 'origin', null, gitCredentialsId)
    println(config.getCredentialsId())
    // Create GitSCM object
    GitSCM gitSCM = new GitSCM(
        [config], // Pass the UserRemoteConfig object as a single-element list
        [new BranchSpec("*/${branchName}")], // Pass the BranchSpec object as a single-element list
        null, // We're not specifying a GitRepositoryBrowser in this case, so we pass null
        null, // We're not specifying a gitTool in this case, so we pass null
        [] // We're not specifying any GitSCMExtension objects in this case, so we pass an empty list
    )

    CpsScmFlowDefinition scmFlow = new CpsScmFlowDefinition(gitSCM, jenkinsfilePath)

    String description = "Pipeline job for ${jobName}"
    job.setDefinition(scmFlow)
    job.setDisplayName(jobName)
    job.setDescription(description)

    def trigger = new GitLabPushTrigger()
    trigger.start(job, true) // true to run immediately after creating the trigger
    job.addTrigger(trigger)

    if (autoBuild) {
        // Schedule the job to run immediately
        job.scheduleBuild2(0)
        println("Auto-build triggered for job: ${jobName}")
    }

    job.save()

    println('Job configuration updated successfully.')
}
String baseRepo = 'https://git1.smoothstack.com/cohorts/2024/2024-03-11_cloud/organizations/care-bear-cuddle-buddies/trey-crossley/aline-financial'
String gitCredentialsId = 'gitlab-login-credential'
String jenkinsfilePath = 'Jenkinsfile'
String branchName = 'develop'

def jobConfigurations = [
    [
        jobName: 'user-microservice-pipeline',
        gitlabRepoUrl: "${baseRepo}/aline-user-microservice.git"
    ],
    [
        jobName: 'underwriter-microservice-pipeline',
        gitlabRepoUrl: "${baseRepo}/aline-underwriter-microservice.git"
    ],
    [
        jobName: 'bank-microservice-pipeline',
        gitlabRepoUrl: "${baseRepo}/aline-bank-microservice.git"
    ],
    [
        jobName: 'transaction-microservice-pipeline',
        gitlabRepoUrl: "${baseRepo}/aline-transaction-microservice.git"
    ],
    [
        jobName: 'account-microservice-pipeline',
        gitlabRepoUrl: "${baseRepo}/aline-account-microservice.git"
    ],
    [
        jobName: 'gateway-pipeline',
        gitlabRepoUrl: "${baseRepo}/aline-gateway.git"
    ],
    [
        jobName: 'admin-portal-pipeline',
        gitlabRepoUrl: "${baseRepo}/aline-admin-portal.git"
    ],
    [
        jobName: 'landing-portal-pipeline',
        gitlabRepoUrl: "${baseRepo}/aline-landing-portal.git"
    ],
    [
        jobName: 'member-dashboard-pipeline',
        gitlabRepoUrl: "${baseRepo}/member-dashboard.git"
    ],
    [
        jobName: 'terraform-pipeline',
        gitlabRepoUrl: "${baseRepo}/terraform.git",
        // autoBuild: true
    ]
]

jobConfigurations.each { config ->
    if (!config.containsKey('autoBuild')) {
        config.autoBuild = false
    }

    createOrUpdatePipelineJob(
        config.jobName,
        config.gitlabRepoUrl,
        gitCredentialsId,
        jenkinsfilePath,
        branchName,
        config.autoBuild
    )
}
