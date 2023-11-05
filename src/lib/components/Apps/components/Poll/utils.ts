import type { PollType, FetchPollsResponse } from './types';

export const getPollsData = (data: FetchPollsResponse, isStudent: boolean) => {
  const pollsData: PollType[] = data
    .sort(
      (a, b) => new Date(b.created_at).getMilliseconds() - new Date(a.created_at).getMilliseconds()
    )
    .map((appsPollItem) => ({
      id: appsPollItem.id,
      courseId: appsPollItem.courseId,
      expiration: appsPollItem.expiration,
      status: appsPollItem.status,
      question: appsPollItem.question,
      author: {
        id: appsPollItem.authorId,
        username: appsPollItem.author.profile.username,
        fullname: appsPollItem.author.profile.fullname,
        avatarUrl: appsPollItem.author.profile.avatar_url
      },
      options: appsPollItem.options.map((option) => ({
        id: option.id,
        label: option.label,
        selectedBy: option.submissions.map((submission) => {
          return {
            id: submission.selectedBy.id,
            username: submission.selectedBy.profile.username,
            fullname: submission.selectedBy.profile.fullname,
            avatarUrl: submission.selectedBy.profile.avatar_url
          };
        })
      }))
    }));

  console.log({ pollsData });
  return pollsData.filter((p) => (isStudent ? p.status === 'public' : true));
};
