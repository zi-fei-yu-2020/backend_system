/*
 Navicat Premium Data Transfer

 Source Server         : SQLlite
 Source Server Type    : SQLite
 Source Server Version : 3035005
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3035005
 File Encoding         : 65001

 Date: 17/10/2023 18:45:09
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for user_userprofile_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS "user_userprofile_user_permissions";
CREATE TABLE "user_userprofile_user_permissions" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "userprofile_id" bigint NOT NULL,
  "permission_id" integer NOT NULL,
  FOREIGN KEY ("userprofile_id") REFERENCES "user_userprofile" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of user_userprofile_user_permissions
-- ----------------------------

-- ----------------------------
-- Indexes structure for table user_userprofile_user_permissions
-- ----------------------------
CREATE INDEX "user_userprofile_user_permissions_permission_id_7f559b23"
ON "user_userprofile_user_permissions" (
  "permission_id" ASC
);
CREATE INDEX "user_userprofile_user_permissions_userprofile_id_68dc814c"
ON "user_userprofile_user_permissions" (
  "userprofile_id" ASC
);
CREATE UNIQUE INDEX "user_userprofile_user_permissions_userprofile_id_permission_id_2e86ceca_uniq"
ON "user_userprofile_user_permissions" (
  "userprofile_id" ASC,
  "permission_id" ASC
);

PRAGMA foreign_keys = true;
