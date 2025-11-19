CREATE OR REPLACE PROCEDURE sp_log_chat_interaction(
  p_user_id IN NUMBER,
  p_session_id IN VARCHAR2,
  p_user_message IN CLOB,
  p_bot_response IN CLOB,
  p_intent IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
  INSERT INTO chat_log (chat_log_id, user_id, session_id, user_message, bot_response, intent, created_at)
  VALUES (seq_chat_log.NEXTVAL, p_user_id, p_session_id, p_user_message, p_bot_response, p_intent, SYSTIMESTAMP);

  INSERT INTO app_log (log_id, user_id, event_type, payload, created_at)
  VALUES (seq_app_log.NEXTVAL, p_user_id, 'CHAT_INTERACTION', 'session='||p_session_id||'; intent='||NVL(p_intent,'-'), SYSTIMESTAMP);

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    INSERT INTO app_log (log_id, user_id, event_type, payload, created_at)
    VALUES (seq_app_log.NEXTVAL, p_user_id, 'CHAT_LOG_ERROR', SQLERRM, SYSTIMESTAMP);
    ROLLBACK;
END sp_log_chat_interaction;
/

CREATE OR REPLACE PROCEDURE sp_register_application(
  p_user_id IN NUMBER,
  p_job_id IN NUMBER,
  p_resume_uri IN VARCHAR2 DEFAULT NULL
) AS
  v_profile CLOB;
BEGIN
  SELECT competencies || '|' || NVL(summary, '') INTO v_profile FROM user_profile WHERE user_id = p_user_id;

  INSERT INTO applications (application_id, user_id, job_id, status, applied_at, resume_uri, anonymized_profile_snapshot)
  VALUES (seq_applications.NEXTVAL, p_user_id, p_job_id, 'SUBMITTED', SYSTIMESTAMP, p_resume_uri, v_profile);

  INSERT INTO app_log (log_id, user_id, event_type, payload, created_at)
  VALUES (seq_app_log.NEXTVAL, p_user_id, 'APPLICATION_SUBMITTED', 'job_id='||p_job_id, SYSTIMESTAMP);

  COMMIT;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    INSERT INTO app_log (log_id, user_id, event_type, payload, created_at)
    VALUES (seq_app_log.NEXTVAL, p_user_id, 'APPLICATION_ERROR', 'No profile found', SYSTIMESTAMP);
    ROLLBACK;
  WHEN OTHERS THEN
    INSERT INTO app_log (log_id, user_id, event_type, payload, created_at)
    VALUES (seq_app_log.NEXTVAL, p_user_id, 'APPLICATION_ERROR', SQLERRM, SYSTIMESTAMP);
    ROLLBACK;
END sp_register_application;
/

CREATE OR REPLACE FUNCTION fn_get_application_summary(p_user_id IN NUMBER) RETURN VARCHAR2 IS
  v_total NUMBER := 0;
  v_submitted NUMBER := 0;
  v_hired NUMBER := 0;
BEGIN
  SELECT COUNT(*) INTO v_total FROM applications WHERE user_id = p_user_id;
  SELECT COUNT(*) INTO v_submitted FROM applications WHERE user_id = p_user_id AND status = 'SUBMITTED';
  SELECT COUNT(*) INTO v_hired FROM applications WHERE user_id = p_user_id AND status = 'HIRED';

  RETURN 'total='||v_total||'; submitted='||v_submitted||'; hired='||v_hired;
EXCEPTION WHEN OTHERS THEN
  RETURN 'error='||SQLERRM;
END fn_get_application_summary;
/
