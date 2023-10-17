/*
 Navicat Premium Data Transfer

 Source Server         : SQLlite
 Source Server Type    : SQLite
 Source Server Version : 3035005
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3035005
 File Encoding         : 65001

 Date: 17/10/2023 18:44:50
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for user_userprofile
-- ----------------------------
DROP TABLE IF EXISTS "user_userprofile";
CREATE TABLE "user_userprofile" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "password" varchar(128) NOT NULL,
  "avatar" varchar(200) NOT NULL,
  "created_at" datetime NOT NULL,
  "permission_id" integer NOT NULL,
  "date_joined" datetime NOT NULL,
  "email" varchar(254) NOT NULL,
  "first_name" varchar(150) NOT NULL,
  "is_active" bool NOT NULL,
  "is_staff" bool NOT NULL,
  "is_superuser" bool NOT NULL,
  "last_login" datetime,
  "last_name" varchar(150) NOT NULL,
  "username" varchar(150) NOT NULL,
  FOREIGN KEY ("permission_id") REFERENCES "user_userpermission" ("type") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  UNIQUE ("username" ASC)
);

-- ----------------------------
-- Records of user_userprofile
-- ----------------------------
INSERT INTO "user_userprofile" VALUES (6, 'pbkdf2_sha256$260000$O1DXuzLA0CfXUxTU3JNUbF$J+LQeiAwTMX/sCPRiLQXdFp18VFkat2Acq1CGH2JYvY=', 'https://cdn.acwing.com/media/user/profile/photo/91657_lg_941861e133.jpeg', '2023-10-16 08:49:35.539608', 3, '2023-10-16 10:35:58.613205', '', '', 1, 0, 0, NULL, '', 'zifeiyu');
INSERT INTO "user_userprofile" VALUES (7, 'pbkdf2_sha256$260000$IxhC1GrK0vIrhSPBK80X2m$Ty9mIUoicIm6bpGkD+ityoeLDZN0Qz5bP7PJNBheS88=', 'https://cdn.acwing.com/media/user/profile/photo/91657_lg_941861e133.jpeg', '2023-10-16 08:50:26.257210', 3, '2023-10-16 10:35:58.613205', '', '', 1, 0, 0, NULL, '', 'zifeiyu1');
INSERT INTO "user_userprofile" VALUES (8, 'pbkdf2_sha256$260000$zsJh193z9L0RtvivzCQxid$g4dfrpfpLNeh9GUoJ7ubK55HACeBNtQCMaKIgetwWi8=', 'https://cdn.acwing.com/media/user/profile/photo/91657_lg_941861e133.jpeg', '2023-10-17 01:07:05.007480', 0, '2023-10-17 01:07:05.007480', '', '', 1, 0, 0, NULL, '', 'zifeiyu2');

-- ----------------------------
-- Auto increment value for user_userprofile
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 8 WHERE name = 'user_userprofile';

-- ----------------------------
-- Indexes structure for table user_userprofile
-- ----------------------------
CREATE INDEX "user_userprofile_permission_id_5cf0aff9"
ON "user_userprofile" (
  "permission_id" ASC
);

PRAGMA foreign_keys = true;
