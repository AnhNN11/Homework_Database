CREATE TABLE "users"(
    "id" BIGINT NOT NULL,
    "email" VARCHAR(255) NULL,
    "password" VARCHAR(255) NULL,
    "role" VARCHAR(255) NULL,
    "avatar_url" TEXT NOT NULL,
    "full_name" VARCHAR(255) NULL,
    "gender" VARCHAR(255) NULL,
    "is_verify_email" BOOLEAN NULL,
    "is_active" BOOLEAN NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NOT NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NOT NULL
);
ALTER TABLE "users" ADD PRIMARY KEY("id");
ALTER TABLE "users" ADD CONSTRAINT "users_email_unique" UNIQUE("email");

CREATE TABLE "courses"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NULL,
    "description" TEXT NULL,
    "price" FLOAT(53) NULL,
    "level" VARCHAR(255) CHECK ("level" IN('')) NULL,
    "instructor_id" BIGINT NULL,
    "image_url" TEXT NULL,
    "status" VARCHAR(255) CHECK ("status" IN('')) NULL,
    "topic_id" BIGINT NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NULL
);
ALTER TABLE "courses" ADD PRIMARY KEY("id");

CREATE TABLE "lessons"(
    "id" BIGINT NOT NULL,
    "title" VARCHAR(255) NULL,
    "resource_url" TEXT NULL,
    "content" VARCHAR(255) NULL,
    "free_preview" BOOLEAN NULL,
    "course_id" BIGINT NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NULL
);
ALTER TABLE "lessons" ADD PRIMARY KEY("id");

CREATE TABLE "enrollments"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NULL,
    "course_id" BIGINT NULL,
    "status" VARCHAR(255) CHECK ("status" IN('')) NULL,
    "content" TEXT NOT NULL,
    "enrollment_date" TIMESTAMP(0) WITH TIME zone NULL,
    "completed_date" TIMESTAMP(0) WITH TIME zone NULL,
    "rate" INTEGER NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NULL
);
ALTER TABLE "enrollments" ADD PRIMARY KEY("id");
CREATE TABLE "posts"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "content" TEXT NULL,
    "resource_url" TEXT NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NOT NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NOT NULL
);
ALTER TABLE "posts" ADD PRIMARY KEY("id");


CREATE TABLE "comments"(
    "id" BIGINT NOT NULL,
    "content" TEXT NULL,
    "post_id" BIGINT NULL,
    "user_id" BIGINT NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NOT NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NOT NULL
);
ALTER TABLE "comments" ADD PRIMARY KEY("id");
CREATE TABLE "reacts"(
    "id" BIGINT NOT NULL,
    "react_type" VARCHAR(255) CHECK ("react_type" IN('')) NULL,
    "reactable_id" BIGINT NULL,
    "type" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NOT NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NOT NULL,
    CONSTRAINT "reacts_reactable_id_post_fk" FOREIGN KEY ("reactable_id") REFERENCES "posts"("id") ON DELETE CASCADE,
    CONSTRAINT "reacts_reactable_id_comment_fk" FOREIGN KEY ("reactable_id") REFERENCES "comments"("id") ON DELETE CASCADE
);
ALTER TABLE "reacts" ADD PRIMARY KEY("id");



CREATE TABLE "expert_applys"(
    "id" BIGINT NOT NULL,
    "cv_url" TEXT NULL,
    "status" VARCHAR(255) NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NOT NULL,
    "user_id" BIGINT NOT NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NOT NULL
);
ALTER TABLE "expert_applys" ADD PRIMARY KEY("id");

CREATE TABLE "topics"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NULL,
    "title" VARCHAR(255) NULL,
    "created_at" TIMESTAMP(0) WITH TIME zone NULL,
    "updated_at" TIMESTAMP(0) WITH TIME zone NULL
);
ALTER TABLE "topics" ADD PRIMARY KEY("id");

ALTER TABLE "expert_applys" ADD CONSTRAINT "expert_applys_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE "posts" ADD CONSTRAINT "posts_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE "comments" ADD CONSTRAINT "comments_post_id_foreign" FOREIGN KEY("post_id") REFERENCES "posts"("id");
ALTER TABLE "courses" ADD CONSTRAINT "courses_topic_id_foreign" FOREIGN KEY("topic_id") REFERENCES "topics"("id");
ALTER TABLE "courses" ADD CONSTRAINT "courses_instructor_id_foreign" FOREIGN KEY("instructor_id") REFERENCES "users"("id");
ALTER TABLE "enrollments" ADD CONSTRAINT "enrollments_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE "comments" ADD CONSTRAINT "comments_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE "lessons" ADD CONSTRAINT "lessons_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE "enrollments" ADD CONSTRAINT "enrollments_id_foreign" FOREIGN KEY("id") REFERENCES "users"("id");

-- Create a function to enforce the constraint
CREATE OR REPLACE FUNCTION check_reactable_id()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.type = 'post' AND NOT EXISTS (SELECT 1 FROM posts WHERE id = NEW.reactable_id)) THEN
        RAISE EXCEPTION 'reactable_id must reference a valid post when type is post';
    ELSIF (NEW.type = 'comment' AND NOT EXISTS (SELECT 1 FROM comments WHERE id = NEW.reactable_id)) THEN
        RAISE EXCEPTION 'reactable_id must reference a valid comment when type is comment';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to call the function before insert or update
CREATE TRIGGER check_reactable_id_trigger
BEFORE INSERT OR UPDATE ON reacts
FOR EACH ROW EXECUTE FUNCTION check_reactable_id();