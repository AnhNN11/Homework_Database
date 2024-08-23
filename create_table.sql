


CREATE TABLE "courses"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "price" FLOAT(53) NOT NULL,
    "level" VARCHAR(255) NOT NULL,
    "instructor_id" BIGINT NOT NULL,
    "image_url" TEXT NOT NULL,
    "status" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "courses" ADD PRIMARY KEY("id");
CREATE TABLE "lessons"(
    "id" BIGINT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "resource_url" TEXT NOT NULL,
    "content" VARCHAR(255) NOT NULL,
    "free_preview" BOOLEAN NOT NULL,
    "course_id" BIGINT NOT NULL
);
ALTER TABLE
    "lessons" ADD PRIMARY KEY("id");
CREATE TABLE "enrollments"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "course_id" BIGINT NOT NULL,
    "status" BIGINT NOT NULL,
    "enrollment_date" BIGINT NOT NULL
);
ALTER TABLE
    "enrollments" ADD PRIMARY KEY("id");
CREATE TABLE "completeds"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "course_id" BIGINT NOT NULL,
    "completed_at" TIMESTAMP(0) WITH
        TIME zone NOT NULL
);
ALTER TABLE
    "completeds" ADD PRIMARY KEY("id");
CREATE TABLE "course_review"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "course_id" BIGINT NOT NULL,
    "content" VARCHAR(255) NOT NULL,
    "rate" INTEGER NOT NULL,
    "created_at" TIMESTAMP(0) WITH
        TIME zone NOT NULL
);
ALTER TABLE
    "course_review" ADD PRIMARY KEY("id");
CREATE TABLE "react_posts"(
    "id" BIGINT NOT NULL,
    "react" VARCHAR(255) NOT NULL,
    "postRef" BIGINT NOT NULL,
    "reactBy" BIGINT NOT NULL
);
ALTER TABLE
    "react_posts" ADD PRIMARY KEY("id");
CREATE TABLE "react_comments"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "comment_id" BIGINT NOT NULL,
    "react" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "react_comments" ADD PRIMARY KEY("id");
CREATE TABLE "users"(
    "id" BIGINT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "role" VARCHAR(255) NOT NULL,
    "avatar_url" TEXT NOT NULL,
    "full_name" VARCHAR(255) NOT NULL,
    "gender" VARCHAR(255) NOT NULL,
    "is_verify_email" BOOLEAN NOT NULL,
    "is_Active" BOOLEAN NOT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
CREATE TABLE "posts"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "content" VARCHAR(255) NOT NULL,
    "resource_url" TEXT NOT NULL,
    "create_At" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "update_At" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL
);
ALTER TABLE
    "posts" ADD PRIMARY KEY("id");
CREATE TABLE "topic_courses"(
    "id" BIGINT NOT NULL,
    "course_id" BIGINT NOT NULL,
    "topic_id" BIGINT NOT NULL
);
ALTER TABLE
    "topic_courses" ADD PRIMARY KEY("id");
CREATE TABLE "expert_apply"(
    "id" BIGINT NOT NULL,
    "cv_url" TEXT NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "user_id" BIGINT NOT NULL
);
ALTER TABLE
    "expert_apply" ADD PRIMARY KEY("id");
CREATE TABLE "comments"(
    "id" BIGINT NOT NULL,
    "content" VARCHAR(255) NOT NULL,
    "postRef" BIGINT NOT NULL,
    "comment_by" BIGINT NOT NULL
);
ALTER TABLE
    "comments" ADD PRIMARY KEY("id");
CREATE TABLE "topic"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0) WITH
        TIME zone NOT NULL,
        "update_at" TIMESTAMP(0)
    WITH
        TIME zone NOT NULL
);
ALTER TABLE
    "topic" ADD PRIMARY KEY("id");
ALTER TABLE
    "expert_apply" ADD CONSTRAINT "expert_apply_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "comments" ADD CONSTRAINT "comments_postref_foreign" FOREIGN KEY("postRef") REFERENCES "posts"("id");
ALTER TABLE
    "react_posts" ADD CONSTRAINT "react_posts_postref_foreign" FOREIGN KEY("postRef") REFERENCES "posts"("id");
ALTER TABLE
    "course_review" ADD CONSTRAINT "course_review_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE
    "topic" ADD CONSTRAINT "topic_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "courses" ADD CONSTRAINT "courses_instructor_id_foreign" FOREIGN KEY("instructor_id") REFERENCES "users"("id");
ALTER TABLE
    "completeds" ADD CONSTRAINT "completeds_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "react_posts" ADD CONSTRAINT "react_posts_reactby_foreign" FOREIGN KEY("reactBy") REFERENCES "users"("id");
ALTER TABLE
    "enrollments" ADD CONSTRAINT "enrollments_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE
    "topic_courses" ADD CONSTRAINT "topic_courses_topic_id_foreign" FOREIGN KEY("topic_id") REFERENCES "topic"("id");
ALTER TABLE
    "completeds" ADD CONSTRAINT "completeds_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE
    "react_comments" ADD CONSTRAINT "react_comments_comment_id_foreign" FOREIGN KEY("comment_id") REFERENCES "comments"("id");
ALTER TABLE
    "topic_courses" ADD CONSTRAINT "topic_courses_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE
    "react_comments" ADD CONSTRAINT "react_comments_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "comments" ADD CONSTRAINT "comments_comment_by_foreign" FOREIGN KEY("comment_by") REFERENCES "users"("id");
ALTER TABLE
    "posts" ADD CONSTRAINT "posts_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "lessons" ADD CONSTRAINT "lessons_course_id_foreign" FOREIGN KEY("course_id") REFERENCES "courses"("id");
ALTER TABLE
    "enrollments" ADD CONSTRAINT "enrollments_id_foreign" FOREIGN KEY("id") REFERENCES "users"("id");
ALTER TABLE
    "course_review" ADD CONSTRAINT "course_review_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");