# Posting a pending review

Only after I approve posting, for this PR, in this conversation. Post only the comments I approved, as I last edited them, keeping the `🤖` tag wherever I left it.

1. Check for a pending review of mine. GitHub allows one per user per PR.

   ```bash
   gh api graphql -f query='query($o:String!,$r:String!,$n:Int!){repository(owner:$o,name:$r){pullRequest(number:$n){id reviews(states:PENDING,first:5){nodes{id author{login}}}}}}' \
     -f o=<owner> -f r=<repo> -F n=<n>
   ```

2. Write each comment body to its own scratchpad file, and build each request with `jq --rawfile` so backticks and quotes survive.
3. Post:
   - **No pending review:** `addPullRequestReview` with `pullRequestId`, no `event`, and `threads: [{path, line, side: "RIGHT", body}]`. Every `line` must sit inside one of the diff's hunks. Leave the review body empty unless I gave you one.
   - **Pending review exists:** `addPullRequestReviewThread` with its `pullRequestReviewId`. Leave my existing comments alone.
   - **Reply to an existing thread:** `addPullRequestReviewThreadReply` with the pending review's ID.
4. Never submit the review, add reactions or resolve threads.
5. Verify: re-read the pending review. Confirm each comment landed on the intended line and the review state is still `PENDING`. If a comment landed wrong, fix it and check again before reporting back.
