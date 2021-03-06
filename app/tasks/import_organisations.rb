require 'gds_api/organisations'

class ImportOrganisations

  def call
    organisation_relationships = {}

    organisations.each do |organisation_data|
      update_or_create_organisation(organisation_data)
      organisation_relationships[organisation_data.details.slug] = child_organisation_slugs(organisation_data)
    end

    update_ancestry(organisation_relationships)

  rescue ActiveRecord::RecordInvalid => invalid
    raise "Couldn't save organisation #{invalid.record.slug} because: #{invalid.record.errors.full_messages.join(',')}"
  end

private

  def organisations_api
    @organisations_api ||= GdsApi::Organisations.new( Plek.current.find('whitehall-admin') )
  end

  def organisations
    organisations_api.organisations.with_subsequent_pages
  end

  def update_or_create_organisation(organisation_data)
    organisation = Organisation.find_or_create_by(slug: organisation_data.details.slug)

    update_data = {
      api_id: organisation_data.id,
      title: organisation_data.title,
      format: organisation_data.format,
      web_url: organisation_data.web_url,
      abbreviation: organisation_data.details.abbreviation,
      govuk_status: organisation_data.details.govuk_status,
      logo_formatted_name: organisation_data.details.logo_formatted_name,
      organisation_brand_colour_class_name: organisation_data.details.organisation_brand_colour_class_name,
      organisation_logo_type_class_name: organisation_data.details.organisation_logo_type_class_name
    }

    if organisation_data.updated_at
      update_data[:api_updated_at] = Time.zone.parse(organisation_data.updated_at)
    end

    if organisation_data.details.closed_at
      update_data[:api_closed_at] = Time.zone.parse(organisation_data.details.closed_at)
    end

    organisation.update!(update_data)
  end

  def child_organisation_slugs(organisation_data)
    organisation_data.child_organisations.map(&:id).collect { |child_organisation_id| child_organisation_id.split('/').last }
  end

  def update_ancestry(organisation_relationships)
    organisation_relationships.each do |organisation_slug, child_organisation_slugs|
      Organisation.where(slug: child_organisation_slugs).map do |child_organisation|
        child_organisation.update_attributes!(parent: Organisation.find_by_slug(organisation_slug))
      end
    end
  end
end
