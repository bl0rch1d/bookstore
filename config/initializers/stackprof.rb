if Rails.env.development?
  Rails.application.config.middleware.use(
    StackProf::Middleware,
    enabled: true,
    mode: :cpu,
    interval: 1000,
    save_every: 100,
    path: 'tmp/stackprof/'
  )
end
