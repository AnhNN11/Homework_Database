-- Insert sample data into users table
INSERT INTO "users" ("id", "email", "password", "role", "avatar_url", "full_name", "gender", "is_verify_email", "is_Active") VALUES
(1, 'instructor1@example.com', 'password1', 'instructor', 'http://example.com/avatar1.jpg', 'Instructor One', 'male', TRUE, TRUE),
(2, 'instructor2@example.com', 'password2', 'instructor', 'http://example.com/avatar2.jpg', 'Instructor Two', 'female', TRUE, TRUE),
(3, 'student1@example.com', 'password3', 'student', 'http://example.com/avatar3.jpg', 'Student One', 'male', TRUE, TRUE),
(4, 'student2@example.com', 'password4', 'student', 'http://example.com/avatar4.jpg', 'Student Two', 'female', TRUE, TRUE);

-- Insert sample data into topic table
INSERT INTO "topic" ("id", "user_id", "title", "created_at", "update_at") VALUES
(1, 3, 'Topic 1', '2023-01-01 10:00:00+00', '2023-01-01 10:00:00+00'),
(2, 4, 'Topic 2', '2023-01-02 11:00:00+00', '2023-01-02 11:00:00+00');

-- Insert sample data into courses table
INSERT INTO "courses" ("id", "name", "description", "price", "level", "instructor_id", "image_url", "status") VALUES
(1, 'Introduction to Programming', 'Learn the basics of programming.', 49.99, 'Beginner', 1, 'http://example.com/image1.jpg', 'active'),
(2, 'Advanced Databases', 'Deep dive into database management systems.', 99.99, 'Advanced', 2, 'http://example.com/image2.jpg', 'active');

-- Insert sample data into topic_courses table
INSERT INTO "topic_courses" ("id", "course_id", "topic_id") VALUES
(1, 1, 1),
(2, 2, 2); 

-- Insert sample data into lessons table
INSERT INTO "lessons" ("id", "title", "resource_url", "content", "free_preview", "course_id") VALUES
(1, 'Lesson 1: Getting Started', 'http://example.com/resource1', 'Introduction to the course.', TRUE, 1),
(2, 'Lesson 2: Variables', 'http://example.com/resource2', 'Understanding variables.', FALSE, 1),
(3, 'Lesson 1: Database Basics', 'http://example.com/resource3', 'Introduction to databases.', TRUE, 2);

-- Insert sample data into enrollments table
INSERT INTO "enrollments" ("id", "user_id", "course_id", "status", "enrollment_date") VALUES
(1, 3, 1, 'active', '2023-01-01 10:00:00+00'),
(2, 4, 2, 'active', '2023-01-02 11:00:00+00');

-- Insert sample data into completed table
INSERT INTO "completed" ("id", "user_id", "course_id", "completed_at") VALUES
(1, 3, 1, '2023-02-01 12:00:00+00'),
(2, 4, 2, '2023-02-02 13:00:00+00');

-- Insert sample data into course_review table
INSERT INTO "course_review" ("id", "user_id", "course_id", "content", "rate", "created_at") VALUES
(1, 3, 1, 'Great course!', 5, '2023-02-03 14:00:00+00'),
(2, 4, 2, 'Very informative.', 4, '2023-02-04 15:00:00+00');

-- Insert sample data into posts table
INSERT INTO "posts" ("id", "user_id", "content", "resource_url", "create_At", "update_At") VALUES
(1, 3, 'This is a post.', 'http://example.com/resource1', '2023-01-01 10:00:00+00', '2023-01-01 10:00:00+00'),
(2, 4, 'This is another post.', 'http://example.com/resource2', '2023-01-02 11:00:00+00', '2023-01-02 11:00:00+00');

-- Insert sample data into react_posts table
INSERT INTO "react_posts" ("id", "react", "postRef", "reactBy") VALUES
(1, 'like', 1, 3),
(2, 'love', 2, 4);
-- Insert sample data into comments table
INSERT INTO "comments" ("id", "content", "postRef", "comment_by") VALUES
(1, 'This is a comment.', 1, 3),
(2, 'This is another comment.', 2, 4);

-- Insert sample data into react_comments table
INSERT INTO "react_comments" ("id", "user_id", "comment_id", "react") VALUES
(1, 3, 1, 'like'),
(2, 4, 2, 'love');


-- Insert sample data into expert_apply table
INSERT INTO "expert_apply" ("id", "cv_url", "status", "created_at", "user_id") VALUES
(1, 'http://example.com/cv1.pdf', 'pending', '2023-01-01 10:00:00+00', 1),
(2, 'http://example.com/cv2.pdf', 'approved', '2023-01-02 11:00:00+00', 2);

DO $$
BEGIN
    FOR i IN 5..104 LOOP
        INSERT INTO "users" ("id", "email", "password", "role", "avatar_url", "full_name", "gender", "is_verify_email", "is_Active") VALUES
        (i, 'user' || i || '@example.com', 'password' || i, CASE WHEN i % 2 = 0 THEN 'student' ELSE 'instructor' END, 'http://example.com/avatar' || i || '.jpg', 'User ' || i, CASE WHEN i % 2 = 0 THEN 'female' ELSE 'male' END, TRUE, TRUE);
    END LOOP;
END $$;

-- Insert sample data into topic table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "topic" ("id", "user_id", "title", "created_at", "update_at") VALUES
        (i, (i % 100) + 1, 'Topic ' || i, '2023-01-01 10:00:00+00'::timestamp + (i * interval '1 day'), '2023-01-01 10:00:00+00'::timestamp + (i * interval '1 day'));
    END LOOP;
END $$;

-- Insert sample data into courses table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "courses" ("id", "name", "description", "price", "level", "instructor_id", "image_url", "status") VALUES
        (i, 'Course ' || i, 'Description for course ' || i, (i * 10)::float, CASE WHEN i % 2 = 0 THEN 'Beginner' ELSE 'Advanced' END, (i % 2) + 1, 'http://example.com/image' || i || '.jpg', 'active');
    END LOOP;
END $$;

-- Insert sample data into topic_courses table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "topic_courses" ("id", "course_id", "topic_id") VALUES
        (i, (i % 100) + 1, (i % 100) + 1);
    END LOOP;
END $$;

-- Insert sample data into lessons table
DO $$
BEGIN
    FOR i IN 4..103 LOOP
        INSERT INTO "lessons" ("id", "title", "resource_url", "content", "free_preview", "course_id") VALUES
        (i, 'Lesson ' || i, 'http://example.com/resource' || i, 'Content for lesson ' || i, CASE WHEN i % 2 = 0 THEN TRUE ELSE FALSE END, (i % 100) + 1);
    END LOOP;
END $$;

-- Insert sample data into enrollments table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "enrollments" ("id", "user_id", "course_id", "status", "enrollment_date") VALUES
        (i, (i % 100) + 1, (i % 100) + 1, 'active', '2023-01-01 10:00:00+00'::timestamp + (i * interval '1 day'));
    END LOOP;
END $$;

-- Insert sample data into completed table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "completed" ("id", "user_id", "course_id", "completed_at") VALUES
        (i, (i % 100) + 1, (i % 100) + 1, '2023-02-01 12:00:00+00'::timestamp + (i * interval '1 day'));
    END LOOP;
END $$;

-- Insert sample data into course_review table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "course_review" ("id", "user_id", "course_id", "content", "rate", "created_at") VALUES
        (i, (i % 100) + 1, (i % 100) + 1, 'Review for course ' || i, (i % 5) + 1, '2023-02-03 14:00:00+00'::timestamp + (i * interval '1 day'));
    END LOOP;
END $$;

-- Insert sample data into posts table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "posts" ("id", "user_id", "content", "resource_url", "create_At", "update_At") VALUES
        (i, (i % 100) + 1, 'Post content ' || i, 'http://example.com/resource' || i, '2023-01-01 10:00:00+00'::timestamp + (i * interval '1 day'), '2023-01-01 10:00:00+00'::timestamp + (i * interval '1 day'));
    END LOOP;
END $$;

-- Insert sample data into react_posts table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "react_posts" ("id", "react", "postRef", "reactBy") VALUES
        (i, CASE WHEN i % 2 = 0 THEN 'like' ELSE 'love' END, (i % 100) + 1, (i % 100) + 1);
    END LOOP;
END $$;

-- Insert sample data into comments table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "comments" ("id", "content", "postRef", "comment_by") VALUES
        (i, 'Comment content ' || i, (i % 100) + 1, (i % 100) + 1);
    END LOOP;
END $$;

-- Insert sample data into react_comments table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "react_comments" ("id", "user_id", "comment_id", "react") VALUES
        (i, (i % 100) + 1, (i % 100) + 1, CASE WHEN i % 2 = 0 THEN 'like' ELSE 'love' END);
    END LOOP;
END $$;

-- Insert sample data into expert_apply table
DO $$
BEGIN
    FOR i IN 3..102 LOOP
        INSERT INTO "expert_apply" ("id", "cv_url", "status", "created_at", "user_id") VALUES
        (i, 'http://example.com/cv' || i || '.pdf', CASE WHEN i % 2 = 0 THEN 'pending' ELSE 'approved' END, '2023-01-01 10:00:00+00'::timestamp + (i * interval '1 day'), (i % 100) + 1);
    END LOOP;
END $$;

























