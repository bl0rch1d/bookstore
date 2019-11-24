module ApplicationHelper
  EMAIL_REGEXP = '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$'.freeze
  PASSWORD_REGEXP = '^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$'.freeze
end
