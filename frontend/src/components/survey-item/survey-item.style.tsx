import { colors } from '@styles/colors';
import styled from 'styled-components';
import { defaultTransition } from 'styles/transitions';

export const SurveyContainer = styled.div`
  border-radius: 12px;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  transition: ${defaultTransition};
  max-height: 200px;

  &:hover {
    transition: ${defaultTransition};
    filter: brightness(1.1);
  }
`;

export const ImageSurvey = styled.div<{ cover: string }>`
  height: 100px;
  background-image: url(${(props) => props.cover});
  background-size: cover;
  border-top-left-radius: 6px;
  border-top-right-radius: 6px;
  transition: 300ms;

  &:hover {
    opacity: 0.7;
    transition: 300ms;
  }
`;

export const DetailsSurvey = styled.div`
  padding: 10px;
  background-color: #222;
  border-bottom-left-radius: 6px;
  border-bottom-right-radius: 6px;
  flex-grow: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  color: ${colors.primaryTxt};
`;

export const TitleSurvey = styled.div`
  font-size: 14px;
  font-weight: bold;
`;

export const DescriptionSurvey = styled.div`
  font-size: 12px;
  padding-top: 4px;
`;

export const QuestionsSurvey = styled.div`
  display: flex;
  align-items: center;
  font-size: 12px;
  padding-top: 12px;
  justify-content: space-between;
  color: #fff;
`;

export const NumberQuestions = styled.div`
  padding-left: 6px;
`;

export const QuestionsSection = styled.div`
  display: flex;
  align-items: center;
`;
