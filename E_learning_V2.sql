CREATE TABLE "courses"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NULL,
    "description" TEXT NULL,
    "price" FLOAT(53) NULL,
    "level" VARCHAR(255) CHECK
        ("level" IN('')) NULL,
        "instructor_id" BIGINT NULL,
        "image_url" TEXT NULL,
        "status" VARCHAR(255)
    CHECK
        ("status" IN('')) NULL,
        "topic_id" BIGINT NULL,
        "created_at" TIMESTAMP(0)
    WITH
        TIME zone NULL,
        "update_at" TIMESTAMP(0)
    WITH
        TIME zone NULL
);
ALTER TABLE
    "courses" ADD PRIMARY KEY("id");
CREATE TABLE "lessons"(
    "id" BIGINT NOT NULL,
    "title" VARCHAR(255) NULL,
    "resource_url" TEXT NULL,
    "content" VARCHAR(255) NULL,
    "free_preview" BOOLEAN NULL,
    "course_id" BIGINT NULL,
    "created_at" TIMESTAMP(0) WITH
        TIME zone NULL,
        "updated_at" TIMESTAMP(0)
    WITH
        TIME zone NULL
);
ALTER TABLE
    "lessons" ADD PRIMARY KEY("id");
CREATE TABLE "enrollments"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NULL,
    "course_id" BIGINT NULL,
    "status" VARCHAR(255) CHECK
        ("status" IN('')) NULL,
        "enrollment_date" TIMESTAMP(0)
    WITH
        TIME zone NULL,
        "completed_date" TIMESTAMP(0)
    WITH
        TIME zone NULL,
        "rate" INTEGER NULL,
        "created_at" TIMESTAMP(0)
    WITH
        TIME zone NULL,
        "updated_at" TIMESTAMP(0)
    WITH
        TIME zone NULL
);
ALTER TABLE
    "enrollments" ADD PRIMARY KEY("id");
CREATE TABLE "reacts"(
    "id" BIGINT NOT NULL,
    "react" VARCHAR(255) CHECK
        ("react" IN('')) NULL,
        "reactable_id" BIGINT NULL,
        "created_at" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL,
        "update_at" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL,
        "type" BIGINT NOT NULL
);
ALTER TABLE
    "reacts" ADD PRIMARY KEY("id");
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
    "created_at" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "updated_at" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
ALTER TABLE
    "users" ADD CONSTRAINT "users_email_unique" UNIQUE("email");
CREATE TABLE "posts"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "content" TEXT NULL,
    "resource_url" TEXT NULL,
    "created_at" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "updated_at" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL
);
ALTER TABLE
    "posts" ADD PRIMARY KEY("id");
CREATE TABLE "expert_applys"(
    "id" BIGINT NOT NULL,
    "cv_url" TEXT NULL,
    "status" VARCHAR(255) NULL,
    "created_at" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "user_id" BIGINT NOT NULL,
        "created_at" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL,
        "updated_at" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL
);
ALTER TABLE
    "expert_applys" ADD PRIMARY KEY("id");
CREATE TABLE "comments"(
    "id" BIGINT NOT NULL,
    "content" TEXT NULL,
    "post_by" BIGINT NULL,
    "comment_by" BIGINT NULL,
    "created_at" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "updated_at" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL
);
ALTER TABLE
    "comments" ADD PRIMARY KEY("id");
CREATE TABLE "topics"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NULL,
    "title" VARCHAR(255) NULL,
    "created_at" TIMESTAMP(0) WITH
        TIME zone NULL,
        "update_at" TIMESTAMP(0)
    WITH
        TIME zone NULL
);
ALTER TABLE
    "topics" ADD PRIMARY KEY("id");
ALTER TABLE
    "expert_applys" ADD CONSTRAINT "expert_applys_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "posts" ADD CONSTRAINT "posts_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "reacts" ADD CONSTRAINT "reacts_reactable_id_foreign" FOREIGN KEY("reactable_id") REFERENCES "comments"("id");
ALTER TABLE
    "comments" ADD CONSTRAINT "comments_post_by_foreign" FOREIGN KEY("post_by") REFERENCES "posts"("id");
ALTER TABLE
    "reacts" ADD CONSTRAINT "reacts_reactable_id_foreign" FOREIGN KEY("reactable_id") REFERENCES "posts"("id");
ALTER TABLE
    "courses" ADD CONSTRAINT "courses_topic_id_foreign" FOREIGN KEY("topic_id") REFERENCES "topics"("id");
ALTER TABLE
    "courses" ADD CONSTRAINT "courses_instructor_id_foreign" FOREIGN KEY("instructor_id") REFERENCES "users"("id");
ALTER TABLE
    "enrollments" ADD CONSTRAINT "enrollments_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE
    "comments" ADD CONSTRAINT "comments_comment_by_foreign" FOREIGN KEY("comment_by") REFERENCES "users"("id");
ALTER TABLE
    "lessons" ADD CONSTRAINT "lessons_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE
    "enrollments" ADD CONSTRAINT "enrollments_id_foreign" FOREIGN KEY("id") REFERENCES "users"("id");