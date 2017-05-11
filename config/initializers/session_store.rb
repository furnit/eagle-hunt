# Be sure to restart your server when you modify this file.

SESSION_KEY = '_viramobl_session'

Rails.application.config.session_store :active_record_store, key: SESSION_KEY

SessionStore = ActionDispatch::Session::ActiveRecordStore.session_class;