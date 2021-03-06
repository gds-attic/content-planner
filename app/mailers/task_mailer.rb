class TaskMailer < ActionMailer::Base
  default from: "DO NOT REPLY <content-planner@digital.cabinet-office.gov.uk>"

  def notify(task, notified_person)
    @task = task
    @notified_person = notified_person
    @url = taskable_url(@task)

    @subject = "#{@task.title} task was completed"

    mail to: @notified_person.email, subject: @subject
  end

  def overdue_notification(task, notified_person)
    @task = task
    @notified_person = notified_person
    @url = taskable_url(@task)

    @subject = "#{@task.title} task is overdue"

    mail to: @notified_person.email, subject: @subject
  end

  private

  def taskable_url(task)
    if task.taskable.is_a?(ContentPlan)
      content_plan_url(task.taskable, anchor: "task_#{task.id}")
    else
      content_url(task.taskable, anchor: "task_#{task.id}")
    end
  end
end
