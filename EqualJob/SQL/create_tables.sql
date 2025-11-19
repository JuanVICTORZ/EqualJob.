CREATE TABLE users (
  user_id NUMBER PRIMARY KEY,
  email VARCHAR2(255) UNIQUE NOT NULL,
  password_hash VARCHAR2(512),
  role VARCHAR2(50) DEFAULT 'CANDIDATE',
  created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
  active CHAR(1) DEFAULT 'Y'
);

CREATE TABLE user_profile (
  profile_id NUMBER PRIMARY KEY,
  user_id NUMBER NOT NULL,
  display_name VARCHAR2(200),
  competencies CLOB,
  summary CLOB,
  created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
  CONSTRAINT fk_up_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE jobs (
  job_id NUMBER PRIMARY KEY,
  company VARCHAR2(200) NOT NULL,
  title VARCHAR2(200) NOT NULL,
  description CLOB,
  inclusion_tags VARCHAR2(200),
  location VARCHAR2(200),
  created_by NUMBER,
  created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
  CONSTRAINT fk_jobs_creator FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE applications (
  application_id NUMBER PRIMARY KEY,
  user_id NUMBER NOT NULL,
  job_id NUMBER NOT NULL,
  status VARCHAR2(50) DEFAULT 'SUBMITTED',
  applied_at TIMESTAMP DEFAULT SYSTIMESTAMP,
  updated_at TIMESTAMP,
  resume_uri VARCHAR2(4000),
  anonymized_profile_snapshot CLOB,
  CONSTRAINT fk_app_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_app_job FOREIGN KEY (job_id) REFERENCES jobs(job_id) ON DELETE CASCADE
);

CREATE TABLE chat_log (
  chat_log_id NUMBER PRIMARY KEY,
  user_id NUMBER,
  session_id VARCHAR2(200),
  user_message CLOB,
  bot_response CLOB,
  intent VARCHAR2(200),
  created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
  CONSTRAINT fk_chat_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE app_log (
  log_id NUMBER PRIMARY KEY,
  user_id NUMBER,
  event_type VARCHAR2(200),
  payload CLOB,
  created_at TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE badges (
  badge_id NUMBER PRIMARY KEY,
  user_id NUMBER NOT NULL,
  badge_code VARCHAR2(100) NOT NULL,
  awarded_at TIMESTAMP DEFAULT SYSTIMESTAMP,
  CONSTRAINT fk_badge_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_jobs_inclusion ON jobs(inclusion_tags);
CREATE INDEX idx_applications_user ON applications(user_id);
CREATE INDEX idx_chat_user ON chat_log(user_id);
