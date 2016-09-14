# contents

Content.seed(:id,
  { id: 1, controller_action_name: 'about#show', key: 'intro', value: File.read("#{Rails.root}/db/fixtures/contents/about/intro.md"), order: 1 },
  { id: 2, controller_action_name: 'about#show', key: 'team', value: File.read("#{Rails.root}/db/fixtures/contents/about/team.md"), order: 2 },
  { id: 3, controller_action_name: 'about#show', key: 'partner', value: File.read("#{Rails.root}/db/fixtures/contents/about/partner.md"), order: 3 },
  { id: 4, controller_action_name: 'about#show', key: 'press', value: File.read("#{Rails.root}/db/fixtures/contents/about/press.md"), order: 4 },
  { id: 5, controller_action_name: 'about#show', key: 'contact', value: File.read("#{Rails.root}/db/fixtures/contents/about/contact.md"), order: 5 },
  { id: 6, controller_action_name: 'application#imprint', key: 'imprint', value: File.read("#{Rails.root}/db/fixtures/contents/imprint.md"), order: 1 },
  { id: 7, controller_action_name: 'application#privacy', key: 'privacy', value: '# Datenschutz', order: 1 },
  { id: 8, controller_action_name: 'application#faq', key: 'faq', value: '# FAQ', order: 1 },
  { id: 9, controller_action_name: 'application#contact', key: 'contact', value: '# Kontakt', order: 1 },
  { id: 10, controller_action_name: 'application#guideline', key: 'guideline', value: '# Leitfaden für Aktionen', order: 1 }
)
