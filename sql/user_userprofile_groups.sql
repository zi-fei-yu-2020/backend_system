/*
 Navicat Premium Data Transfer

 Source Server         : SQLlite
 Source Server Type    : SQLite
 Source Server Version : 3035005
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3035005
 File Encoding         : 65001

 Date: 17/10/2023 18:44:59
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for user_userprofile_groups
-- ----------------------------
DROP TABLE IF EXISTS "user_userprofile_groups";
CREATE TABLE "user_userprofile_groups" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "userprofile_id" bigint NOT NULL,
  "group_id" integer NOT NULL,
  FOREIGN KEY ("userprofile_id") REFERENCES "user_userprofile" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of user_userprofile_groups
-- ----------------------------

-- ----------------------------
-- Indexes structure for table user_userprofile_groups
-- ----------------------------
CREATE INDEX "user_userprofile_groups_group_id_98cc4038"
ON "user_userprofile_groups" (
  "group_id" ASC
);
CREATE INDEX "user_userprofile_groups_userprofile_id_49724c40"
ON "user_userprofile_groups" (
  "userprofile_id" ASC
);
CREATE UNIQUE INDEX "user_userprofile_groups_userprofile_id_group_id_52847a61_uniq"
ON "user_userprofile_groups" (
  "userprofile_id" ASC,
  "group_id" ASC
);

PRAGMA foreign_keys = true;
