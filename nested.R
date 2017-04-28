
# Vincent Cau 
# 28 avril 2017
# Nested Set with R

library(readr)
library(dplyr)
library(data.tree)


#import sample
ex_tree <- read_delim("test.csv", ";", escape_double = FALSE, trim_ws = TRUE, locale = locale(date_names = "fr", encoding = "latin1"))


# set the path string
ex_tree$pathString <-  ex_tree$path


# build the tree
c <- as.Node(ex_tree)
s

# add an id
c$Set(id = 1:c$totalCount)

# set the descendants for each node
c$Set(descendants = c(function(self) self$totalCount  ) )

# set the ancestors for each node
c$Set(ancestors = c(function(self) self$level  ) )

# add an parent id (useless)
c$Set(id_parent = c(function(self) self$parent$id  ) )

# convert to data frame
res <- ToDataFrameTree(c, "name", "id", "pathString", "ancestors", "descendants", "id_parent", "leafCount")

# calcul the nested set left and right
res <- res %>% mutate(left = 2 * id - ancestors, right = 2 * id - ancestors + 2 * descendants - 1) %>% select(id, name, pathString, id_parent, lvl = ancestors, lft = left, rgt = right, leafCount, total_child_count = descendants-1 )


res # IT work !!!
